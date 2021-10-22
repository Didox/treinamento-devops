#!/bin/bash

cd 08-jenkins/deploy-infra-img-java-app/terraform
/home/ubuntu/terraform init
/home/ubuntu/terraform apply -auto-approve

echo "Aguardando criação de maquinas ..."
sleep 10 # 10 segundos

echo $"[ec2-dev-img-jenkins]" > ../ansible/hosts # cria arquivo
echo "$(/home/ubuntu/terraform output | grep public_dns | awk '{print $2;exit}')" | sed -e "s/\",//g" >> ../ansible/hosts # captura output faz split de espaco e replace de ",

echo "Aguardando criação de maquinas ..."
sleep 10 # 10 segundos

cd ../ansible
ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key /home/ubuntu/treinamentoItau