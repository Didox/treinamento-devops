#!/bin/bash

ANSIBLE_OUT=$(ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/Desktop/devops/treinamentoItau)
echo $ANSIBLE_OUT

MYSQL_POD_NAME=$(echo $ANSIBLE_OUT | grep -oE "(mysql-.*? )" )

cat <<EOF > restore-dump-mysql.yml
- hosts: all
  become: yes
  tasks:
    - name: "Create dabatase"
      shell: echo "create database SpringWebYoutubeTest;"| kubectl exec -it $MYSQL_POD_NAME --tty -- mysql -uroot -ppassword_mysql 
    
    - name: "Restore dump"
      shell: cat /root/k8s-deploy/1.2-dump-mysql.sql  | kubectl exec -it $MYSQL_POD_NAME --tty -- mysql -uroot -ppassword_mysql SpringWebYoutubeTest
EOF

ansible-playbook -i hosts restore-dump-mysql.yml -u ubuntu --private-key ~/Desktop/devops/treinamentoItau
