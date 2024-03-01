Some VMware authorization role definitions need to be created for packer.
The following command sets can be run to create the "Packer to vSphere Integration" role.

cd vsphare-role
terraform init
terraform plan -out=tfplan
terraform apply tfplan