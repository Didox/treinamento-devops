#!/bin/bash

cd 0-terraform
~/terraform/terraform init
~/terraform/terraform fmt
~/terraform/terraform apply -auto-approve

echo $"[ec2-jenkins]" > ../1-ansible/hosts # cria arquivo
echo "$(~/terraform/terraform output | grep public_dns | awk '{print $2;exit}')" | sed -e "s/\",//g" >> ../1-ansible/hosts # captura output faz split de espaco e replace de ",

echo "Aguardando criação de maquinas ..."
sleep 30 # 30 segundos

cd ../1-ansible
ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/projetos/devops/id_rsa_itau_treinamento

cd ../0-terraform
~/terraform/terraform output

echo $"Agora somente abrir a URL: http://$(~/terraform/terraform output | grep public | awk '{print $2;exit}'):8080" | sed -e "s/\",//g"

ID_MAQUINA=$(~/terraform/terraform output | grep id | awk '{print $2;exit}')
echo ${ID_MAQUINA/\",/}

cd ../2-terraform-ami/

~/terraform/terraform init
~/terraform/terraform fmt
~/terraform/terraform apply -var="resource_id=${ID_MAQUINA/\",/}" -auto-approve 
~/terraform/terraform output
