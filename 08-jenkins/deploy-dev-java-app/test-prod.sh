#!/bin/bash
cd 08-jenkins/deploy-infra-img-java-app/terraform

regex='Validar CPF'

uri=$(terraform output | grep public_ip-prod | awk '{print $2;exit}' | sed -e "s/\",//g")
body=$(curl "http://$uri")

if [[ $body =~ $regex ]]
then 
    echo "::::: app dev está no ar :::::"
    exit 0
else
    echo "::::: app dev não está no ar :::::"
    exit 1
fi