#!/bin/sh

PATH_TO_LOGGER="$GRUPO/so7508/pprincipal.log"
INPUT_ACCEPTED_PATH="$DIRIN/ok/"
OUTPUT_COMMISSIONS_PATH="$DIROUT/comisiones/"
APPROVED_CARDS_PATH="$DIRMAE/tarjetashomologadas.txt"
MERCHANT_REGISTER="$DIRMAE/comercios.txt"

ACTUAL_CYCLE=1
TIME_TO_SLEEP=60

export INPUT_ACCEPTED_PATH
export OUTPUT_COMMISSIONS_PATH
export APPROVED_CARDS_PATH
export MERCHANT_REGISTER

#Función para escribir en el log.
writeInLogger() {
  if [ -z "$1" ]; then
    return 0
  fi

  type=$2

  if [ -z "$type" ]; then
    type='INF'
  fi
  
  currentTime=$(date '+%d/%m/%Y %H:%M:%S')
  echo "$currentTime-$type-$1-pprincipal.sh-$USER" >>"${PATH_TO_LOGGER}"
}

 #Función para mover novedades al directorio de rechazados.
sendToRejectedFolder() {
  message=$2
  
  if [ -z "${message}" ]; then
    message='Razón desconocida.'
  fi
  
  if echo "$1" | grep -vq '/'; then
    inputPath=$DIRIN
  fi
  
  mv "$inputPath/$1" $DIRRECH
  file=$(echo $1 | sed 's/.*\/\(.*\)/\1$/')
  writeInLogger "Archivo de novedades \"$file\" rechazado por el siguiente motivo: \"${message}\"" "WAR"
}

#Función para corroborar que el formato del nombre del archivo de novedades sea el esperado.
checkNameFiles() {
  while read nameFile; do
    if ! echo "${nameFile}" | grep -q '^C[0-9]\{8\}_Lote[0-9]\{4\}$'; then
      sendToRejectedFolder "${nameFile}" "Formato del nombre incorrecto."
    else
      echo "$nameFile"
    fi
  done
}

#Función para corroborar la validez de archivo de novedades.
checkForCorrectParsedFiles() {
  while read file; do
    if [ ! -s "$DIRIN/$file" ]; then
      sendToRejectedFolder "${file}" "Archivo vacío."
    elif ! [ -r $DIRIN/$file ] && [ -f $DIRIN/$file ]; then
      sendToRejectedFolder "${file}" "No es un archivo regular legible."
      continue
    elif ! file "$DIRIN/$file" | grep -q 'text'; then
      sendToRejectedFolder "${file}" "Archivo no es de texto."
      continue
    else
      echo "${file}"
    fi
  done
}

#Función para mover un archivo de novedades al directorio de novedades aceptadas.
moveToValidFiles() {
  while read file; do
    mv "$DIRIN/$file" ${INPUT_ACCEPTED_PATH}
    writeInLogger "Archivo \"$file\" movido al directorio de novedades aceptadas."
  done
}

#Función para comprobar que el comercio este en el maestro de comercios.
checkForValidMerchantCode() {
  while read line; do
    if ! echo "$line" | sed 's/.*C\([0-9]\{8\}\)_Lote.\{4\}$/^\1/' | grep -q -f- $MERCHANT_REGISTER; then
      sendToRejectedFolder "${line}" "Código de comercio no está presente en el maestro de comercios."
    else
      echo "$line"
    fi
  done
}

#Función para corroborar que la cabecera sea aceptable.
checkTFH() {
  fileHead=$(head -1 "$1")
  merchantCode=$(echo "$fileHead" | cut -f3 -d",")
  fileMerchantCode=$(echo "${file}" | sed 's/.*C\([0-9]\{8\}\)_.*/\1/')
  numberTRX=$(echo $fileHead | cut -f7 -d",")

  if [ "${fileHead%%,*}" != "TFH" ]; then
    errorMessage="No existe el registro de cabecera."

  elif [ "$merchantCode" != "$fileMerchantCode" ]; then
    errorMessage="Código de comercio distinto al del nombre del archivo."

  elif [ "$numberTRX" -eq "00000" ] || [ $numberTRX -ne $(($(wc -l $1 | cut -f1 -d" ") - 1)) ]; then
    errorMessage="Cantidad de registros de transacciones inválida."

  else
    return 0
  fi

  sendToRejectedFolder "${1}" "${errorMessage}"
  return 1
}

#Función para corroborar que las transacciones sean aceptables.
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
      errorMessage="Tipo de registro inválido, debe ser TFD."
      break

    elif [ "$(echo "$line" | cut -f2 -d",")" -ne $counter ]; then
      errorMessage="Número de registro incorrecto."
      break

    elif [ "$processingCode" != "$VALID_PROCESSING_CODE1" ] && [ "$processingCode" != "$VALID_PROCESSING_CODE2" ]; then
      errorMessage="Código de proceso inválido."
      break
    fi
    if ! echo "$line" | awk -F, '{print "^"$5","}' | grep -q -f- ${APPROVED_CARDS_PATH}; then
      errorMessage="Método de pago inexistente."
      break
    fi

  done <"$filename"

  if [ ${#errorMessage} -ne 0 ]; then
    sendToRejectedFolder "${filename}" "${errorMessage}"
    return 1
  fi

  return 0
}

#Función para comprobar la validez de los registros de cabecera y transacciones de los archivos de novedades.
checkAcceptedFiles() {
  while read fileName; do
    file="$INPUT_ACCEPTED_PATH$fileName"
    checkTFH "$file" && checkTFD "$file"
  done
}

#Función para comprobar si un lote ya fue procesado.
checkForRepeatedFIle() {
  while read fileName; do
    if ls $DIRPROC | grep -q "^$fileName$"; then
      sendToRejectedFolder "$fileName" 'Archivo de novedades ya procesado.'
    else
      echo "$fileName"
    fi
  done
}

#Función para procesar los archivos de novedades aceptados.
processFiles() {
  while read file; do
    writeInLogger "INPUT"
    writeInLogger "$file"
    writeInLogger "OUTPUT"
    writeInLogger "$($DIRBIN/salida1.bash "$file")"
    writeInLogger "$($DIRBIN/salida2.bash "$file")"
    mv "${INPUT_ACCEPTED_PATH}$file" $DIRPROC
  done
}

#Ejecución del ciclo principal.
while true; do
  writeInLogger "Voy por el ciclo ${ACTUAL_CYCLE}"
  ls ${DIRIN} -I'ok' | checkNameFiles | checkForCorrectParsedFiles | checkForValidMerchantCode | checkForRepeatedFIle | moveToValidFiles
  ls $INPUT_ACCEPTED_PATH | checkAcceptedFiles
  ls $INPUT_ACCEPTED_PATH | processFiles
  ACTUAL_CYCLE=$((ACTUAL_CYCLE + 1))
  sleep $TIME_TO_SLEEP
done
