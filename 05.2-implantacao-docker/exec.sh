#!/bin/bash

cd terraform/
terraform init

export TF_VAR_senha="root352desafio53"

terraform apply -auto-approve

echo "Aguardando máquina ..."
sleep 15  # espera um pouco

DNS=$(terraform output public_dns)
DNS=$(echo $DNS | sed -e "s/\"//g")

export RDS=$(terraform output rds)
RDS=$(echo $RDS | sed -e "s/\"//g")

cd ../ansible

echo "
[java-api-docker]
$DNS
" > hosts

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ../../ssh/id_rsa

ssh -i ../../ssh/id_rsa ubuntu@$DNS -o ServerAliveInterval=60