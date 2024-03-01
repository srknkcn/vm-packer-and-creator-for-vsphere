#!/usr/bin/env bash

#export TF_LOG=trace 
export TF_LOG=debug
#export TF_LOG=info 
#export TF_LOG=wanr 
#export TF_LOG=error

terraform init
terraform plan
terraform apply -auto-approve

rm -rf .terraform*
