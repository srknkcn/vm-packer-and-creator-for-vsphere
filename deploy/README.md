To create a VM with Terraform, the necessary configuration for the VM must first be processed into the yaml file.
The "vm-deploy-variables.yaml" file contains the configuration of all virtual machines.
For example:

```
dhcp:
    os_family: rhel
    vsphere_content_library_ovf: "linux-rhel-8.8-main"
    vsphere_datacenter: "MAIN"
    vsphere_cluster: "Master"
    vsphere_datastore: "RaidA"
    vsphere_network: "VLAN 1"
    vm_name: dhcp
    vm_cpus: 1
    vm_memory: 4096
    vm_disk_size: 60
    vm_hostname: dhcp
    vm_ipv4_address: 192.168.1.172
    vm_ipv4_netmask: 24
    vm_ipv4_gateway: 192.168.1.2
    vm_domain: domain.com
    vm_dns_suffix_list: domain.com
    vm_dns_server_list: 192.168.1.100
```

A "dhcp" server is created by using the "dhcp" tag above. It is specified in which cluster the VM will be created and which data store it will use.
Also how many CPU and memory it will use. Disk size indicates how many GB disks will be created.
A server whose clone process is completed is created by giving the hostname value to be used for Linux and the IPV4 information to be defined.

After the configuration is completed, the template vm folder is automatically created using this configuration.

For example, to create k8s-dev-bastion, the "./vm-deploy.sh k8s-dev-bastion" command is run by giving it a parameter.
The relevant command creates a directory with the tag defined in yaml under the ".terraform_vm" directory and automatically creates files in it.

The following command can be run to create the k8s-iac environment.

`./vm-deploy.sh k8s-iac-bastion k8s-iac-node1 k8s-iac-node2 k8s-iac-node3 k8s-iac-worker1 k8s-iac-worker2`
