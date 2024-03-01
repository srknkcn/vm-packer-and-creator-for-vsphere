#!/bin/bash      

if test -z "$1" 
then
      echo "One or more vm_name must be given as parameter. Example: ./vm-deploy.sh dhcp dns redis"
      exit
fi

if [ ! -d ".terraform_vm" ]; then
  echo ".terraform_vm does not exist."
  mkdir .terraform_vm
fi

for host in "$@"
do
    echo "CREATING $host VIRTUAL MACHINE..."

    os_family=$(yq -r=false e ".$host.os_family" vm-deploy-variables.yaml)
    vsphere_content_library_ovf=$(yq -r=false e ".$host.vsphere_content_library_ovf" vm-deploy-variables.yaml)
    vsphere_datacenter=$(yq -r=false e ".$host.vsphere_datacenter" vm-deploy-variables.yaml)
    vsphere_cluster=$(yq -r=false e ".$host.vsphere_cluster" vm-deploy-variables.yaml)
    vsphere_datastore=$(yq -r=false e ".$host.vsphere_datastore" vm-deploy-variables.yaml)
    vsphere_network=$(yq -r=false e ".$host.vsphere_network" vm-deploy-variables.yaml)
    vm_name=$(yq -r=false e ".$host.vm_name" vm-deploy-variables.yaml)
    vm_cpus=$(yq e ".$host.vm_cpus" vm-deploy-variables.yaml)
    vm_memory=$(yq e ".$host.vm_memory" vm-deploy-variables.yaml)
    vm_disk_size=$(yq e ".$host.vm_disk_size" vm-deploy-variables.yaml)
    vm_hostname=$(yq -r=false e ".$host.vm_hostname" vm-deploy-variables.yaml)
    vm_ipv4_address=$(yq -r=false e ".$host.vm_ipv4_address" vm-deploy-variables.yaml)
    vm_ipv4_netmask=$(yq -r=false e ".$host.vm_ipv4_netmask" vm-deploy-variables.yaml)
    vm_ipv4_gateway=$(yq -r=false e ".$host.vm_ipv4_gateway" vm-deploy-variables.yaml)
    vm_domain=$(yq -r=false e ".$host.vm_domain" vm-deploy-variables.yaml)
    vm_dns_suffix_list=$(yq -r=false e ".$host.vm_dns_suffix_list" vm-deploy-variables.yaml)
    vm_dns_server_list=$(yq -r=false e ".$host.vm_dns_server_list" vm-deploy-variables.yaml)

    deploy_variables=("os_family" "vsphere_content_library_ovf" "vsphere_datacenter" "vsphere_cluster" "vsphere_datastore" "vsphere_network" "vm_name" "vm_cpus" "vm_memory" "vm_disk_size" "vm_hostname" "vm_ipv4_address" "vm_ipv4_netmask" "vm_ipv4_gateway" "vm_domain" "vm_dns_suffix_list" "vm_dns_server_list")

    for var in "${deploy_variables[@]}" ; do
        if [ -z "${!var}" ] ; then
            echo "$var is not set for $host vm"
            exit 1
        fi
    done

    # echo "os_family"
    # echo "vsphere_content_library_ovf"
    # echo "vsphere_datacenter=$vsphere_datacenter"
    # echo "vsphere_cluster=$vsphere_cluster"
    # echo "vsphere_datastore=$vsphere_datastore"
    # echo "vsphere_network=$vsphere_network"
    # echo "vm_name=$vm_name"
    # echo "vm_cpus=$vm_cpus"
    # echo "vm_memory=$vm_memory"
    # echo "vm_name=$vm_name"
    # echo "vm_disk_size=$vm_disk_size"
    # echo "vm_hostname=$vm_hostname"
    # echo "vm_ipv4_address=$vm_ipv4_address"
    # echo "vm_ipv4_netmask=$vm_ipv4_netmask"
    # echo "vm_ipv4_gateway=$vm_ipv4_gateway"
    # echo "vm_domain=$vm_domain"
    # echo "vm_dns_suffix_list=$vm_dns_suffix_list"
    # echo "vm_dns_server_list=$vm_dns_server_list"

    if [ -d ".terraform_vm/$host" ]; then
      #echo ".terraform_vm/$host exist."
      rm -rf .terraform_vm/$host
    fi

    mkdir .terraform_vm/$host

    if [ "$os_family" == "ubuntu" ]; then
      metadata=`sed -e "s/{{vm_name}}/$vm_name/g;s/{{vm_hostname}}/$vm_hostname/g;s/{{vm_ipv4_address}}/$vm_ipv4_address/g;s/{{vm_ipv4_netmask}}/$vm_ipv4_netmask/g;s/{{vm_ipv4_gateway}}/$vm_ipv4_gateway/g;s/{{vm_dns_suffix_list}}/$vm_dns_suffix_list/g;s/{{vm_dns_server_list}}/$vm_dns_server_list/g;" templates/$os_family/metadata.yml`
      echo "$metadata" > .terraform_vm/$host/metadata.yml
    fi

    tfvars=`sed -e "s/{{os_family}}/$os_family/g;s/{{vsphere_content_library_ovf}}/$vsphere_content_library_ovf/g;s/{{vsphere_datacenter}}/$vsphere_datacenter/g;s/{{vsphere_cluster}}/$vsphere_cluster/g;s/{{vsphere_datastore}}/$vsphere_datastore/g;s/{{vsphere_network}}/$vsphere_network/g;s/{{vm_name}}/$vm_name/g;s/{{vm_cpus}}/$vm_cpus/g;s/{{vm_memory}}/$vm_memory/g;s/{{vm_disk_size}}/$vm_disk_size/g;s/{{vm_hostname}}/$vm_hostname/g;s/{{vm_ipv4_address}}/$vm_ipv4_address/g;s/{{vm_ipv4_netmask}}/$vm_ipv4_netmask/g;s/{{vm_ipv4_gateway}}/$vm_ipv4_gateway/g;s/{{vm_domain}}/$vm_domain/g;s/{{vm_dns_suffix_list}}/$vm_dns_suffix_list/g;s/{{vm_dns_server_list}}/$vm_dns_server_list/g;" templates/$os_family/terraform.tfvars`
    echo "$tfvars" > .terraform_vm/$host/terraform.tfvars

    cp templates/$os_family/main.tf .terraform_vm/$host
    cp templates/$os_family/variables.tf .terraform_vm/$host
    cp templates/$os_family/versions.tf .terraform_vm/$host
    cp templates/run.sh .terraform_vm/$host

    echo "$host vm terraform files created in folder .terraform_vm/$host"
    cd .terraform_vm/$host
    ./run.sh
    cd ../..

    echo "$host VIRTUAL MACHINE CREATED"

done

rm -rf .terraform_vm
