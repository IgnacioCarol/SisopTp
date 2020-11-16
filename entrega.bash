#!/bin/bash

#$GRUPO/so7508/pprincipal.log
PATH_TO_LOGGER="./loggerFiles/logger.txt"
#$GRUPO/input
INPUT_PATH="./inputTest/"
INPUT_ACCEPTED_PATH="${INPUT_PATH}ok/"
#$GRUPO/rechazos
REJECTED_PATH="./rechazos"
#$DIRMAE/comercios.txt
MERCHANT_REGISTER="${INPUT_PATH}/merchantForTest"
OUTPUT_PLACE="./loggerFiles/"
ACTUAL_CYCLE=1
TIME_TO_SLEEP=5

#this place to check for installation
if [ ! -d "${INPUT_PATH}" ]; then
  echo "error: Folder ${FILE_PATH} does not exist or you do not have access to it." >&2
  exit 1
fi

#Ending check

sendToRejectedFolder() {
  message=$2
  if [ -z "${message}" ]; then
    message='unknown reason'
  fi
  mv "${INPUT_PATH}$1" ${REJECTED_PATH}
  echo "File $1 move to rejected because ${message}" >> ${PATH_TO_LOGGER}
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
    elif [[ ! (-r ${INPUT_PATH}$file && -f ${INPUT_PATH}$file) ]]; then
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
    echo "File $file move to accepted" >>${PATH_TO_LOGGER}
  done
}

checkForValidMerchantCode() {
  while read line; do
    if ! echo "$line" | sed 's/.*C\([0-9]\{8\}\)_Lote.\{4\}$/\1/' | grep -q -f- $MERCHANT_REGISTER; then
      sendToRejectedFolder "${line}" "Code is not at merchants possible code"
    else
      echo "$line"
    fi
  done
}

if [ ! -d "$OUTPUT_PLACE" ]; then
  mkdir "$OUTPUT_PLACE"
  echo "Folder created at ${OUTPUT_PLACE}"
fi

while true; do
  #checkPath
  echo "Voy por el ciclo ${ACTUAL_CYCLE}" >>${PATH_TO_LOGGER}
  ls ${INPUT_PATH} -I'ok' | checkNameFiles | checkForCorrectParsedFiles | checkForValidMerchantCode | moveToValidFiles
  ACTUAL_CYCLE=$((ACTUAL_CYCLE + 1))
  sleep $TIME_TO_SLEEP
done
