# Copyright 2023-2024 Broadcom. All rights reserved.
# SPDX-License-Identifier: BSD-2

/*
    DESCRIPTION:
    Ansible credential variables used for Linux builds.
    - Variables are passed to and used by configuration scripts.
*/

// Ansible Credentials
ansible_username = "ansible"
ansible_key      = "ecdsa-sha2-nistp521 AAAAE2VjZHNhL******************************************PWMFgYkamC0fITQgw== ansible vm-iac"

/*
  ssh-keygen -t ecdsa -b 521 -C "ansible vm-iac" -f ~/.ssh/ansible_id_ecdsa 
  build_key_passphrase: NULL
*/