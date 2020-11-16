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