#!/bin/bash

cd 0-terraform
~/terraform/terraform destroy -auto-approve

cd ../2-terraform-ami/
~/terraform/terraform destroy -auto-approve
