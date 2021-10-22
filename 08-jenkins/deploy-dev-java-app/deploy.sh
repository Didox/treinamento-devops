#!/bin/bash

cd 08-jenkins/deploy-dev-java-app/terraform
/home/ubuntu/terraform init
/home/ubuntu/terraform apply -auto-approve

echo "Aguardando criação de maquinas ..."
sleep 10 # 10 segundos

echo $"[ec2-ec2-devs-jenkins]" > ../ansible/hosts # cria arquivo
echo "$(/home/ubuntu/terraform output | grep public_dns-0 | awk '{print $2;exit}')" | sed -e "s/\",//g" >> ../ansible/hosts # captura output faz split de espaco e replace de ",
echo "$(/home/ubuntu/terraform output | grep public_dns-1 | awk '{print $2;exit}')" | sed -e "s/\",//g" >> ../ansible/hosts # captura output faz split de espaco e replace de ",
echo "$(/home/ubuntu/terraform output | grep public_dns-2 | awk '{print $2;exit}')" | sed -e "s/\",//g" >> ../ansible/hosts # captura output faz split de espaco e replace de ",

echo "Aguardando criação de maquinas ..."
sleep 10 # 10 segundos

cd ../ansible

echo "Executando ansible ::::: [ ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key /var/lib/jenkins/.ssh/id_rsa ]"
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key /var/lib/jenkins/.ssh/id_rsa