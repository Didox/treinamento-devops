#!/bin/bash

cd 08-jenkins/deploy-dev-java-app/terraform
terraform init
TF_VAR_ami_dev='ami-061f0c171f96a3b0f' terraform apply -auto-approve

echo "Aguardando criação de maquinas ..."
sleep 10 # 10 segundos

echo $"[ec2-ec2-devs-jenkins]" > ../ansible/hosts # cria arquivo
echo "$(terraform output | grep public_ip-stage | awk '{print $2;exit}')" | sed -e "s/\",//g" >> ../ansible/hosts # captura output faz split de espaco e replace de ",

echo "Aguardando criação de maquinas ..."
sleep 10 # 10 segundos

cd ../ansible

echo "Executando ansible ::::: [ ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key /var/lib/jenkins/chave-privada.pem ]"
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key /var/lib/jenkins/chave-privada.pem