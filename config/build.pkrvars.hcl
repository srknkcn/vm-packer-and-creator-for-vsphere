# Copyright 2023-2024 Broadcom. All rights reserved.
# SPDX-License-Identifier: BSD-2

/*
    DESCRIPTION:
    Build account variables used for all builds.
    - Variables are passed to and used by guest operating system configuration files (e.g., ks.cfg, autounattend.xml).
    - Variables are passed to and used by configuration scripts.
*/

// Default Account Credentials
build_username           = "iac"
build_password           = "*****************"
build_password_encrypted = "$*********kSjLbGuFnvs****or.ZmDd2PuFlxer*****************TOW68PoflncsNn0"
build_key                = "ecdsa-sha2-nistp521 AAAAE2Vj***************************************************NypcPlkfNwdA== iac vm-iac"

/*
  docker run -it --rm alpine:latest
  mkpasswd -m sha512

  ssh-keygen -t ecdsa -b 521 -C "iac vm-iac" -f ~/.ssh/iac_id_ecdsa
*/
