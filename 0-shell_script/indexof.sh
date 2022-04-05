#!/bin/bash

param1=$1
retorno=`echo "$param1" | grep -o "teste.*"`
# retorno=$(echo "$param1" | grep -o "teste.*")
# echo "=======[$retorno]========="

if [ -z "$retorno" ]; then
  echo "Venho nulo"
else
  echo "Não venho nulo"
fi


# echo "Today is $(date)"
# ## or ##
# echo "Today is `date`"


# myuser="$(grep '^vivek' /etc/passwd)"

# retorno=("$param1" | grep -o "teste.*")
# echo "=======[$retorno]========="
# # echo $param1 | grep -o "teste.*"

