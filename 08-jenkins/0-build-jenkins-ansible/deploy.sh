#!/bin/bash

cd 0-terraform
~/terraform/terraform init
~/terraform/terraform fmt
~/terraform/terraform apply -auto-approve

echo "Aguardando criação de maquinas ..."
sleep 10 # 10 segundos

echo "[ec2-jenkins]" > ../1-ansible/hosts # cria arquivo
echo "$(~/terraform/terraform output | grep public_dns | awk '{print $2;exit}')" | sed -e "s/\",//g" >> ../1-ansible/hosts # captura output faz split de espaco e replace de ",

echo "Aguardando criação de maquinas ..."
sleep 20 # 20 segundos

cd ../1-ansible
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/Desktop/devops/Treinamento

cd ../0-terraform
~/terraform/terraform output

echo "Agora somente abrir a URL: http://$(~/terraform/terraform output | grep public | awk '{print $2;exit}'):8080" | sed -e "s/\",//g"

# open "http://$(~/terraform/terraform output | grep public | awk '{print $2;exit}'):8080" | sed -e "s/\",//g"" #mac
# explorer "http://$(~/terraform/terraform output | grep public | awk '{print $2;exit}'):8080" | sed -e "s/\",//g"" #windows
# nautilus "http://$(~/terraform/terraform output | grep public | awk '{print $2;exit}'):8080" | sed -e "s/\",//g"" #linux

ID_MAQUINA=$(~/terraform/terraform output | grep id | awk '{print $2;exit}')
echo ${ID_MAQUINA/\",/}

# cd ../2-terraform-ami/

# ~/terraform/terraform init
# ~/terraform/terraform fmt
# ~/terraform/terraform apply -var="resource_id=${ID_MAQUINA/\",/}" -auto-approve 
# # ~/terraform/terraform apply -var="resource_id=${ID_MAQUINA/\",/} versao=0.0.2" -auto-approve 
# ~/terraform/terraform output
