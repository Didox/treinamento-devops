#!/bin/bash

param1=$1
param2=$2
param3=$3
if [ $param1 == "1" ]; then
  echo "fazendo uma verificação com condicional"
elif [ $param2 == "alunos" ]; then
  echo "foi com alunos"
else
  echo "tratamento com o else"
fi

echo "a variavel de entrada é: ($param1, $param2, $param3)"