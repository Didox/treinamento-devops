#!/bin/bash

# cd 08-jenkins/deploy-infra-img-java-app/terraform
# curl "http://www.$(/home/ubuntu/terraform output | grep public_dns | awk '{print $2;exit}')" | sed -e "s/\",//g"


hostname_or_ip_address='http://ec2-54-234-28-182.compute-1.amazonaws.com/'

if ping -c 1 -W 1 "$hostname_or_ip_address"; then
  echo "$hostname_or_ip_address is alive"
else
  echo "$hostname_or_ip_address is pining for the fjords"
fi
