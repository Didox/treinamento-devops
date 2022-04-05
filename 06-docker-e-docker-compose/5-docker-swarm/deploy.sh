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
ANSIBLE_OUT=$(ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/projetos/devops/devops-acesso-sh.pem)

#### Mac ###
SWARM_JOIN_WORKER=$(echo $ANSIBLE_OUT | grep -oE "( docker swarm join.*?2377)'" | head -n 1 | sed 's/\\//g' | sed "s/'t//g" | sed "s/'//g" | sed "s/'//g" | sed "s/,//g")
#### Linix ###
# SWARM_JOIN_WORKER=$(echo $ANSIBLE_OUT | grep -oP "( docker swarm join.*?2377)'" | head -n 1 | sed 's/\\//g' | sed "s/'t//g" | sed "s/'//g" | sed "s/'//g" | sed "s/,//g")

echo $ANSIBLE_OUT
echo $SWARM_JOIN_WORKER

cat <<EOF > 2-provisionar-swarm-worker-auto-shell.yml
- hosts:
  - ec2-swarm-w1
  - ec2-swarm-w2
  - ec2-swarm-w3
  become: yes
  tasks:
    - name: "Fazendo join swarm worker no master"
      shell: $SWARM_JOIN_WORKER
EOF

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts 2-provisionar-swarm-worker-auto-shell.yml -u ubuntu --private-key ~/projetos/devops/devops-acesso-sh.pem

cat <<EOF > 3-provisionar-swarm-master-auto-shell.yml
- hosts:
  - ec2-swarm-m1
  become: yes
  tasks:
    - shell: docker swarm join-token manager
      register: ps
    - debug:
        msg: " '{{ ps.stdout_lines }}' "
EOF

ANSIBLE_OUT=$(ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts 3-provisionar-swarm-master-auto-shell.yml -u ubuntu --private-key ~/projetos/devops/devops-acesso-sh.pem)
#### Mac ###

SWARM_JOIN_MANAGER=$(echo $ANSIBLE_OUT | grep -oE "( docker swarm join.*?2377)'" | head -n 1 | sed 's/\\//g' | sed "s/'t//g" | sed "s/'//g" | sed "s/'//g" | sed "s/,//g")
#### Linix ###
# SWARM_JOIN_MANAGER=$(echo $ANSIBLE_OUT | grep -oP "( docker swarm join.*?2377)'" | head -n 1 | sed 's/\\//g' | sed "s/'t//g" | sed "s/'//g" | sed "s/'//g" | sed "s/,//g")

echo $ANSIBLE_OUT
echo $SWARM_JOIN_MANAGER


cat <<EOF > 4-provisionar-swarm-master-auto-shell.yml
- hosts:
  - ec2-swarm-m2
  - ec2-swarm-m3
  become: yes
  tasks:
    - shell: docker swarm leave --force
    
    - name: "Fazendo join swarm master no master"
      shell: $SWARM_JOIN_MANAGER

    - shell: docker node ls
      register: ps
    - debug:
        msg: " '{{ ps.stdout_lines }}' "
EOF

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts 4-provisionar-swarm-master-auto-shell.yml -u ubuntu --private-key ~/projetos/devops/devops-acesso-sh.pem
