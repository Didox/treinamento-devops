#!/bin/bash
cd 0-terraform
~/terraform/terraform init
~/terraform/terraform apply -auto-approve

echo  "Aguardando a criação das maquinas ..."
sleep 5

ID_M1=$(~/terraform/terraform output | grep 'swarm-master 1 -' | awk '{print $4;exit}')
ID_M1_DNS=$(~/terraform/terraform output | grep 'swarm-master 1 -' | awk '{print $9;exit}' | cut -b 8-)

ID_M2=$(~/terraform/terraform output | grep 'swarm-master 2 -' | awk '{print $4;exit}')
ID_M2_DNS=$(~/terraform/terraform output | grep 'swarm-master 2 -' | awk '{print $9;exit}' | cut -b 8-)

ID_M3=$(~/terraform/terraform output | grep 'swarm-master 3 -' | awk '{print $4;exit}')
ID_M3_DNS=$(~/terraform/terraform output | grep 'swarm-master 3 -' | awk '{print $9;exit}' | cut -b 8-)

ID_W1=$(~/terraform/terraform output | grep 'swarm-workers 1 -' | awk '{print $4;exit}')
ID_W1_DNS=$(~/terraform/terraform output | grep 'swarm-workers 1 -' | awk '{print $9;exit}' | cut -b 8-)

ID_W2=$(~/terraform/terraform output | grep 'swarm-workers 2 -' | awk '{print $4;exit}')
ID_W2_DNS=$(~/terraform/terraform output | grep 'swarm-workers 2 -' | awk '{print $9;exit}' | cut -b 8-)

ID_W3=$(~/terraform/terraform output | grep 'swarm-workers 3 -' | awk '{print $4;exit}')
ID_W3_DNS=$(~/terraform/terraform output | grep 'swarm-workers 3 -' | awk '{print $9;exit}' | cut -b 8-)

echo "
[ec2-swarm-m1]
$ID_M1_DNS
[ec2-swarm-m2]
$ID_M2_DNS
[ec2-swarm-m3]
$ID_M3_DNS

[ec2-swarm-w1]
$ID_W1_DNS
[ec2-swarm-w2]
$ID_W2_DNS
[ec2-swarm-w3]
$ID_W3_DNS
" > ../2-ansible/hosts


cd ../2-ansible/
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/projetos/devops/devops-acesso-sh.pem

