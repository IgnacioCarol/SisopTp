#!/bin/bash
fileToUse=$1
NAME_FILE=''
setFileName() {
  NAME_FILE=$(echo $INPUT_ACCEPTED_PATH"$1}" | sed 's/.*C\([0-9]\{8\}\)_Lote.*/\1/' | grep -f- "$MERCHANT_REGISTER" | sed 's/^[0-9]\{8\},\([0-9]\{8\}\),.*/\1/')
  NAME_FILE=$NAME_FILE$(grep '^TFH' $INPUT_ACCEPTED_PATH"$1" | cut -d',' -f5 | sed 's/\(.\{4\}\)\(.\{2\}\).*/-\1-\2/')".txt"
}

setCharge() {
  while read line; do
    txr_amount=$(echo "$line" | cut -d',' -f11 | sed 's/^0*\([^0].*\)/\1/')
    values=$(echo "$line" | awk -F, '$1=="TFD" {print "^"$5",\(\w*,\)\{"3+$12/111111"\}"}' | grep -o -f- $APPROVED_CARDS_PATH | sed 's/\w*,\(\w*\).*\([0-9]\{6\}\),$/\2,\1/' | sed 's/^0*\([^0].*\),/\1 /')
    rate=$(echo "$values" | cut -f1 -d' ')
    CHARGE_LINE=$((txr_amount * rate / 10000))
    echo "$CHARGE_LINE $values"
  done

}
writeCharge() {
  numberLine=2
  while read charge; do
    values=($charge)
    chargeToWrite=$(printf "%06d" "${values[1]}")','$(printf "%012d" "${values[0]}")','$(printf "%-25s" "${values[2]}")
    awk -F, -v LINE=$numberLine 'NR==LINE {print $2","$3","$4","$5",TEXT,"$9","$10","$11","$12","$13}' $INPUT_ACCEPTED_PATH"$file" |
    sed "s/\(.*\),TEXT,/$file,\1,$chargeToWrite,/" >> $OUTPUT_COMMISSIONS_PATH"$NAME_FILE"
    numberLine=$((numberLine + 1))
  done
}

mainProgress() {
  file=$1
  setFileName "$file"
  awk -F, 'NR!=1' $INPUT_ACCEPTED_PATH"$file" | setCharge | writeCharge
  echo "$NAME_FILE"
}

mainProgress "$fileToUse"
