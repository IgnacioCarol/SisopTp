#!/bin/bash
fileToUse=$1
inputPathAccepted="./inputTest/ok/"
pathToMerchantRegister="./merchantForTest"
paymentsPath="./payment.txt"
comissionsPath="./comisiones/"
NAME_FILE=''
CHARGE_LINE=0
setFileName() {
  NAME_FILE=$(echo $inputPathAccepted"$1}" | sed 's/.*C\([0-9]\{8\}\)_Lote.*/\1/' | grep -f- "$pathToMerchantRegister" | sed 's/^[0-9]\{8\},\([0-9]\{8\}\),.*/\1/')
  NAME_FILE=$NAME_FILE$(grep '^TFH' $inputPathAccepted"$1" | cut -d',' -f5 | sed 's/\(.\{4\}\)\(.\{2\}\).*/-\1-\2/')".txt"
}

setCharge() {
  while read line; do
    txr_amount=$(echo "$line" | cut -d',' -f11 | sed 's/^0*\([^0].*\)/\1/')
    values=$(echo "$line" | awk -F, '$1=="TFD" {print "^"$5",\(\w*,\)\{"3+$12/111111"\}"}' | grep -o -f- $paymentsPath | sed 's/\w*,\(\w*\).*\([0-9]\{6\}\),$/\2,\1/' | sed 's/^0*\([^0].*\),/\1 /')
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
    awk -F, -v LINE=$numberLine 'NR==LINE {print $2","$3","$4","$5",TEXT,"$9","$10","$11","$12","$13}' $inputPathAccepted"$file" |
    sed "s/\(.*\),TEXT,/$file,\1,$chargeToWrite,/" >> $comissionsPath"$NAME_FILE"
    numberLine=$((numberLine + 1))
  done
}

mainProgress() {
  file=$1
  setFileName "$file"
  awk -F, 'NR!=1' $inputPathAccepted"$file" | setCharge | writeCharge
  echo "$NAME_FILE"
}

mainProgress "$fileToUse"
