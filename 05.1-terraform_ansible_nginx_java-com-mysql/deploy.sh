#!/bin/bash

cd terraform
~/terraform/terraform init
~/terraform/terraform apply -auto-approve

echo  "Aguardando a criação das maquinas ..."
sleep 5

HOST_DNS=$(~/terraform/terraform output | grep 'PUBLIC_DNS=' | awk '{print $1;exit}' | cut -b 13- | sed "s/\",//g")

echo "
[ec2-java]
$HOST_DNS
" > ../ansible/hosts

cd ../ansible

export ANSIBLE_HOST_KEY_CHECKING=False 
export USER=root
export PASSWORD=root 
export DATABASE=SpringWebYoutube 

ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/Desktop/devops/treinamentoItau

echo  "Abrindo site no navegador"
sleep 10

open "http://$HOST_DNS"

echo  "Acessando via SH"
sleep 5
ssh -i ~/Desktop/devops/treinamentoItau ubuntu@$HOST_DNS -o ServerAliveInterval=60