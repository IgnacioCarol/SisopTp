#!/bin/bash

#$GRUPO/so7508/pprincipal.log
FILE_TO_LOGGER="./loggerFiles/logger.txt"
#
INPUT_PATH="./inputTest/"
OUTPUT_PLACE="./loggerFiles/"
ACTUAL_CYCLE=1
TIME_TO_SLEEP=5


#this place to check for installation



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