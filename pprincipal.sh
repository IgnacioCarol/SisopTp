#!/bin/sh

#Todo Make this file a .sh and fix the problems associated with that. Also fix paths with bugs, force an error in checkAccepted
#$GRUPO/so7508/pprincipal.log
PATH_TO_LOGGER="./loggerFiles/logger.txt"
#$GRUPO/input
INPUT_PATH="./inputTest/"
INPUT_ACCEPTED_PATH="${INPUT_PATH}ok/"
APPROVED_CARDS_PATH="./payment.txt"
#$GRUPO/rechazos
REJECTED_PATH="./rechazos"
#$DIRMAE/comercios.txt
MERCHANT_REGISTER="./merchantForTest"
OUTPUT_PLACE="./loggerFiles/"
ACTUAL_CYCLE=1
TIME_TO_SLEEP=5
PROCESSED_FILES="./processFiles"
OUTPUT_COMMISSIONS_PATH="./comisiones/"

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
  echo "$1" >>${PATH_TO_LOGGER}
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
  writeInLogger "File $1 move to rejected because ${message}"
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

if [ ! -d "$OUTPUT_PLACE" ]; then
  mkdir "$OUTPUT_PLACE"
  echo "Folder created at ${OUTPUT_PLACE}"
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
  echo "Voy por el ciclo ${ACTUAL_CYCLE}" >>${PATH_TO_LOGGER}
  ls ${INPUT_PATH} -I'ok' | checkNameFiles | checkForCorrectParsedFiles | checkForValidMerchantCode | moveToValidFiles
  ls $INPUT_ACCEPTED_PATH | checkAcceptedFiles
  ls $INPUT_ACCEPTED_PATH | processFiles
  ACTUAL_CYCLE=$((ACTUAL_CYCLE + 1))
  sleep $TIME_TO_SLEEP
done
