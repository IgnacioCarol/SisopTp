#!/bin/sh

if [ -z "$1" ] || [ "$1" = '--iniciarproceso' ]; then
  GRUPO=$(grep "^GRUPO-" instalarTP.conf | sed 's/GRUPO-\(.*\)/\1/')
  DIRMAE=$(grep "^DIRMAE-" instalarTP.conf | sed 's/DIRMAE-\(.*\)/\1/')
else
  kill "$(ps aux | grep 'pprincipal' | head -1 | sed "s/$USER\s*\([0-9]*\).*/\1/")"
  exit 0
fi
OUTPUT_PLACE="$GRUPO/so7508/"
OUTPUT_COMMISSIONS="$GRUPO/output/"
PATH_TO_LOGGER="${OUTPUT_PLACE}pprincipal.log"
INPUT_PATH="$GRUPO/input/"
INPUT_ACCEPTED_PATH="${INPUT_PATH}ok/"
APPROVED_CARDS_PATH="$DIRMAE/tarjetashomologadas.txt"
REJECTED_PATH="$GRUPO/rechazos"
MERCHANT_REGISTER="$DIRMAE/comercios.txt"
ACTUAL_CYCLE=1
TIME_TO_SLEEP=60
PROCESSED_FILES="$GRUPO/lotes"
OUTPUT_COMMISSIONS_PATH="${OUTPUT_COMMISSIONS}comisiones/"

export INPUT_ACCEPTED_PATH
export APPROVED_CARDS_PATH
export OUTPUT_COMMISSIONS_PATH
export MERCHANT_REGISTER
#this place to check for installation
if [ ! -d "${INPUT_PATH}" ]; then
  echo "error: Folder ${FILE_PATH} does not exist or you do not have access to it." >&2
  exit 1
fi

#Ending check
writeInLogger() {
  if [ -z "$1" ]; then
    return 0
  fi
  type=$2
  if [ -z "${type}" ]; then
    type='INF'
  fi
  currentTime=$(date +"%D %T")
  echo "$currentTime - $type - $1 - pprincipal.sh - $USER" >>"${PATH_TO_LOGGER}"
}
sendToRejectedFolder() {
  message=$2
  if [ -z "${message}" ]; then
    message='unknown reason'
  fi
  if echo "$1" | grep -vq '/'; then
    inputPath=$INPUT_PATH
  fi
  mv "${inputPath}$1" ${REJECTED_PATH}
  file=$(echo $1 | sed 's/.*\/\(.*\)/\1$/')
  writeInLogger "File $file move to rejected because ${message}" "WAR"
}

checkNameFiles() {
  while read nameFile; do
    if ! echo "${nameFile}" | grep -q '^C[0-9]\{8\}_Lote[0-9]\{4\}$'; then
      sendToRejectedFolder "${nameFile}" "Incorrect naming"
    else
      echo "$nameFile"
    fi
  done
}

checkForCorrectParsedFiles() {
  while read file; do
    if [ ! -s "${INPUT_PATH}$file" ]; then
      sendToRejectedFolder "${file}" "is empty"
    elif ! [ -r ${INPUT_PATH}$file ] && [ -f ${INPUT_PATH}$file ]; then
      sendToRejectedFolder "${file}" "is not readable or regular"
      continue
    elif ! file ${INPUT_PATH}"$file" | grep -q 'text'; then
      sendToRejectedFolder "${file}" "file is not a text one"
      continue
    else
      echo "${file}"
    fi
  done
}

moveToValidFiles() {
  while read file; do
    mv "${INPUT_PATH}$file" ${INPUT_ACCEPTED_PATH}
    writeInLogger "File $file move to accepted"
  done
}

checkForValidMerchantCode() {
  while read line; do
    if ! echo "$line" | sed 's/.*C\([0-9]\{8\}\)_Lote.\{4\}$/^\1/' | grep -q -f- $MERCHANT_REGISTER; then
      sendToRejectedFolder "${line}" "Code is not at merchants possible code"
    else
      echo "$line"
    fi
  done
}

checkTFH() {
  fileHead=$(head -1 "$1")
  merchantCode=$(echo "$fileHead" | cut -f3 -d",")
  fileMerchantCode=$(echo "${file}" | sed 's/.*C\([0-9]\{8\}\)_.*/\1/')
  numberTRX=$(echo $fileHead | cut -f7 -d",")

  if [ "${fileHead%%,*}" != "TFH" ]; then
    errorMessage="The header record (TFH) dosen't exist"

  elif [ "$merchantCode" != "$fileMerchantCode" ]; then
    errorMessage="The merchant codes aren't equal"

  elif [ "$numberTRX" -eq "00000" ] || [ $numberTRX -ne $(($(wc -l $1 | cut -f1 -d" ") - 1)) ]; then
    errorMessage="Invalid amount of transaction registers"

  else
    return 0
  fi

  sendToRejectedFolder "${1}" "${errorMessage}"
  return 1
}

checkTFD() {
  VALID_PROCESSING_CODE1=000000 #Maybe if we use it in other part we can define as global
  VALID_PROCESSING_CODE2=111111
  filename=$1
  errorMessage=""

  counter=0
  while read line; do
    counter=$((counter + 1))
    if [ $counter -eq 1 ]; then continue; fi

    #Checking variables from the file one by one
    processingCode=$(echo $line | cut -f12 -d",")

    if [ "${line%%,*}" != "TFD" ]; then
      errorMessage="Invalid record type, must be TFD"
      break

    elif [ "$(echo "$line" | cut -f2 -d",")" -ne $counter ]; then
      errorMessage="The record number and the register number aren't equal"
      break

    elif [ "$processingCode" != "$VALID_PROCESSING_CODE1" ] && [ "$processingCode" != "$VALID_PROCESSING_CODE2" ]; then
      errorMessage="Invalid processing code"
      break
    fi
    if ! echo "$line" | awk -F, '{print "^"$5","}' | grep -q -f- ${APPROVED_CARDS_PATH}; then
      errorMessage="The payment method doesn't exist"
      break
    fi

  done <"$filename"

  if [ ${#errorMessage} -ne 0 ]; then
    sendToRejectedFolder "${filename}" "${errorMessage}"
    return 1
  fi

  return 0
}

checkAcceptedFiles() {
  while read fileName; do
    file="$INPUT_ACCEPTED_PATH$fileName"
    checkTFH "$file" && checkTFD "$file"
  done
}

checkForRepeatedFIle() {
  while read fileName; do
    if ls $PROCESSED_FILES | grep -q "^$fileName$"; then
      sendToRejectedFolder "$fileName" 'File already processed'
    else
      echo "$fileName"
    fi
  done
}

if [ ! -d "$OUTPUT_PLACE" ]; then
  mkdir "$OUTPUT_PLACE"
  writeInLogger "Folder created at ${OUTPUT_PLACE}"
fi

if [ ! -d "$OUTPUT_COMMISSIONS" ]; then
  mkdir "$OUTPUT_COMMISSIONS"
  writeInLogger "Folder created at ${OUTPUT_PLACE}"
fi

processFiles() {
  while read file; do
    writeInLogger "INPUT"
    writeInLogger "$file"
    writeInLogger "OUTPUT"
    writeInLogger "$(./salida1.bash "$file")"
    writeInLogger "$(./salida2.bash "$file")"
    mv "${INPUT_ACCEPTED_PATH}$file" $PROCESSED_FILES
  done
}
chmod a+x ./salida1.bash && chmod a+x ./salida2.bash
while true; do
  writeInLogger "Voy por el ciclo ${ACTUAL_CYCLE}"
  ls ${INPUT_PATH} -I'ok' | checkNameFiles | checkForCorrectParsedFiles | checkForValidMerchantCode | checkForRepeatedFIle | moveToValidFiles
  ls $INPUT_ACCEPTED_PATH | checkAcceptedFiles
  ls $INPUT_ACCEPTED_PATH | processFiles
  ACTUAL_CYCLE=$((ACTUAL_CYCLE + 1))
  sleep $TIME_TO_SLEEP
done
