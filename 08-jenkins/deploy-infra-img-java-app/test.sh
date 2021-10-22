#!/bin/bash
cd 08-jenkins/deploy-infra-img-java-app/terraform

body="http://$(/home/ubuntu/terraform output | grep public_dns | awk '{print $2;exit}')" | sed -e "s/\",//g"

regex='Welcome to nginx!'

if [[ $url =~ $regex ]]
then 
    echo "$url nginx está no ar"
    exit 0
else
    echo "$url nginx não está no ar"
    exit 1
fi