#!/bin/bash

FILE=$1
OUTPUT_PATH="./comisiones/"
APPROVED_CARDS_FILE="./payment.txt"

getSettlementFileName() {
  #$1 = TFD  $2 TFH
  idPayment=$(echo $1 | cut -f5 -d",")
  settlementFileName=$(grep "^${idPayment},.*" $APPROVED_CARDS_FILE | cut -d"," -f6)
  date=$(echo $2 | cut -d"," -f5 | sed 's/\(.\{4\}\)\(.\{2\}\).*/\1-\2/')
  settlementFileName+="-${date}.txt"
}

output1() {
  file=$INPUT_ACCEPTED_PATH$1
  filename=${file##*/}
  tfh=$(head -1 "$file")
  registersNotComp=($(awk -F, 'NR!=1' $file | sort -t, -k3n | sed 's/^\(.\{3\},[0-9]\{8\}\),\(.*\)/\2,\1/' | tr ',' ' ' | rev | uniq -u -f13 | rev | tr ' ' ',' | sed 's/\(.*\),\(TFD,.*\)$/\2,\1/'))
  for tfd in "${registersNotComp[@]}"; do
    settlementFileName=""
    getSettlementFileName $tfd $tfh
    echo "$(echo $tfd | sed "s/^TFD/$filename/")" >>"${OUTPUT_PATH}${settlementFileName}"
  done
  echo "$settlementFileName;${#registersNotComp[*]}"
}

output1 "$FILE"
