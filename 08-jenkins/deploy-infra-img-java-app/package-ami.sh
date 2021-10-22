#!/bin/bash

VERSAO=$(git describe --tags $(git rev-list --tags --max-count=1))

cd 08-jenkins/deploy-infra-img-java-app/terraform
RESOURCE_ID=$(/home/ubuntu/terraform output | grep resource_id | awk '{print $2;exit}' | sed -e "s/\",//g")

cd ../terraform-ami
/home/ubuntu/terraform init
TF_VAR_versao=$VERSAO TF_VAR_resource_id=$RESOURCE_ID /home/ubuntu/terraform apply -auto-approve
