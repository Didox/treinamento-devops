#!/bin/bash

#### mostra os arquivos que estão dentro de uma pasta
# for i in $(ls ~); do
#     echo "arquivos: $i"
#     # echo `pwd && echo "/" && echo $i`
# done

#### Um for simples
# for i in 1 2 3 4 5; do
#   echo "counter: $i"
# done

CONTADOR=0
while [  $CONTADOR -lt 5 ]; do
  echo "$CONTADOR";
  let CONTADOR=CONTADOR+1; 
done