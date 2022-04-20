#!/bin/bash

cd terraform/
export TF_VAR_senha="root352desafio53"
terraform destroy -auto-approve
