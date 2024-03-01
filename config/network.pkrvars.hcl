# Copyright 2023-2024 Broadcom. All rights reserved.
# SPDX-License-Identifier: BSD-2

/*
    DESCRIPTION:
    Network variables used for all builds.
    - Variables are passed to and used by guest operating system configuration files (e.g., ks.cfg).

*/

// VM Network Settings (default DHCP)
vm_ip_address = "192.168.1.171"
vm_ip_netmask = 24
vm_ip_gateway = "192.168.1.2"
vm_dns_list   = [ "192.168.1.100" ]

ntp_server1 = "tr.pool.ntp.org"
ntp_server2 = "pool.ntp.org"
ssh_port = "22"