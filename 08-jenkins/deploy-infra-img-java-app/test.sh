#!/bin/bash
cd 08-jenkins/deploy-infra-img-java-app/terraform

echo "http://$(/home/ubuntu/terraform output | grep public_ip | awk '{print $2;exit}')" | sed -e "s/\",//g"

body=$(curl "http://$(/home/ubuntu/terraform output | grep public_ip | awk '{print $2;exit}')" | sed -e "s/\",//g")

regex='Welcome to nginx!'

if [[ $body =~ $regex ]]
then 
    echo "::::: nginx está no ar :::::"
    exit 0
else
    echo "::::: nginx não está no ar :::::"
    exit 1
fi