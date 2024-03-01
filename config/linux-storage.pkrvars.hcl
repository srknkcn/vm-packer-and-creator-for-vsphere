# Copyright 2023-2024 Broadcom. All rights reserved.
# SPDX-License-Identifier: BSD-2

/*
    DESCRIPTION:
    Storage variables used for Linux builds.
    - Variables are passed to and used by guest operating system configuration files (e.g., ks.cfg).
*/

// VM Storage Settings
vm_disk_device     = "sda"
vm_disk_use_swap   = false
vm_disk_partitions = [
  {
    name = "efi"
    size = 1024,
    format = {
      label  = "EFIFS",
      fstype = "fat32",
    },
    mount = {
      path    = "/boot/efi",
      options = "",
    },
    volume_group = "",
  },
  {
    name = "boot"
    size = 1024,
    format = {
      label  = "BOOTFS",
      fstype = "xfs",
    },
    mount = {
      path    = "/boot",
      options = "",
    },
    volume_group = "",
  },
  {
    name = "root"
    size = -1,
    format = {
      label  = "ROOTFS",
      fstype = "xfs",
    },
    mount = {
      path    = "/",
      options = "",
    },
    volume_group = "",
  },
]