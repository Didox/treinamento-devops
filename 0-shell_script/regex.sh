#!/bin/bash

tem_google="google"
conteudo_google=$(curl -s www.google.com) # o site do google não vem com encode UTF-8 pode ter diferença no resultado dependendo do seu S.O.

if [[  "$conteudo_google" =~ "$tem_google" ]]
then
    echo "achei"
else
    echo "nao achei"
fi



# body=$(curl -s https://www.google.com)
# # body=$(curl -s https://www.torneseumprogramador.com.br)
# # body="Um teste feito com alunos"
# teste_regex="google"

# echo $body

# if [[ $body =~ $teste_regex ]]
# then
#   echo "achei aqui"
# else
#   echo "não achei aqui"
# fi



# ===== validação com o shell script com indexof ======
# teste_regex="google"
# body=$(curl https://www.google.com | grep -o "$teste_regex.*" )

# if [ -z "$body" ]; then
#   echo "Venho nulo"
# else
#   echo "Não venho nulo"
# fi