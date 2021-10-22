#!/bin/bash
cd 08-jenkins/deploy-infra-img-java-app/terraform

regex='Validar CPF'

uri=$(/home/ubuntu/terraform output | grep public_ip-0 | awk '{print $2;exit}' | sed -e "s/\",//g")
body=$(curl "http://$uri")

if [[ $body =~ $regex ]]
then 
    echo "::::: app dev está no ar :::::"
    uri=$(/home/ubuntu/terraform output | grep public_ip-1 | awk '{print $2;exit}' | sed -e "s/\",//g")
    body=$(curl "http://$uri")

    if [[ $body =~ $regex ]]
    then 
        echo "::::: app stage está no ar :::::"
        uri=$(/home/ubuntu/terraform output | grep public_ip-2 | awk '{print $2;exit}' | sed -e "s/\",//g")
        body=$(curl "http://$uri")

        if [[ $body =~ $regex ]]
        then 
            echo "::::: app prod  está no ar :::::"
            exit 0
        else
            echo "::::: app prod não está no ar :::::"
            exit 1
        fi
    else
        echo "::::: app stage não está no ar :::::"
        exit 1
    fi
else
    echo "::::: app dev não está no ar :::::"
    exit 1
fi