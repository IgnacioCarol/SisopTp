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
  filesWithBadNames=$(ls ${INPUT_PATH} -I'ok' | grep -v '^C[0-9]\{8\}_Lote[0-9]\{4\}$')
  for file in ${filesWithBadNames}; do
    sendToRejectedFolder "${file}" "Incorrect naming"
  done
}

checkForCorrectParsedFiles() {
  possibleCorrectFiles=$(ls ${INPUT_PATH} -I'ok')
  for file in ${possibleCorrectFiles}; do
    if [ ! -s "${INPUT_PATH}$file" ]; then
      sendToRejectedFolder "${file}" "is empty"
      continue
    fi
    if [[ ! (-r ${INPUT_PATH}$file && -f ${INPUT_PATH}$file) ]]; then
      sendToRejectedFolder "${file}" "is not readable or regular"
      continue
    fi
    if ! file ${INPUT_PATH}"$file" | grep -q 'text'; then
      sendToRejectedFolder "${file}" "file is not a text one"
      continue
    fi
  done
}

checkPath() {
	if [ ! -r "${FILE_PATH}" ] ; then
		echo "error: File ${FILE_PATH} does not exist or you do not have access to it." >&2; exit 1
	fi
	return 0;
}

if [ ! -d "$OUTPUT_PLACE" ]; then
  mkdir "$OUTPUT_PLACE";
  echo "Folder created at ${OUTPUT_PLACE}"
fi

while true; do
	#checkPath
	echo "Voy por el ciclo ${ACTUAL_CYCLE}" >> ${FILE_TO_LOGGER};
	# shellcheck disable=SC2016
	#pathToSearch=$(grep '${NAME_OF_FILE}' "${FILE_PATH}"| awk -F "= " '{ print $2}')
	# shellcheck disable=SC2010
	#ls "$pathToSearch" | grep '\.png$' | cat >> "$OUTPUT_PLACE/$ACTUAL_CYCLE";
	ACTUAL_CYCLE=$(( ACTUAL_CYCLE + 1 ))
	sleep $TIME_TO_SLEEP;
done