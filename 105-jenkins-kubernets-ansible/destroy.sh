#!/bin/bash

# cd 0-terraform
# ID_MAQUINA=$(~/terraform/terraform output | grep id | awk '{print $2;exit}')
# echo ${ID_MAQUINA/\",/}

# cd 2-terraform-ami/
# TF_VAR_resource_id=xxx TF_VAR_versao=v0.1.1 ~/terraform/terraform destroy -auto-approve

cd ../0-terraform
~/terraform/terraform destroy -auto-approve
