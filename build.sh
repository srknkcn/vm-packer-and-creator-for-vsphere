#!/usr/bin/env bash
# Copyright 2023-2024 Broadcom. All Rights Reserved.
# SPDX-License-Identifier: BSD-2

set -e

follow_link() {
  FILE="$1"
  while [ -h "$FILE" ]; do
    # On Mac OS, readlink -f doesn't work.
    FILE="$(readlink "$FILE")"
  done
  echo "$FILE"
}

if [ "$1" == "--debug" ] || [ "$1" == "-d" ]; then
  debug_option="-debug"
  shift
else
  debug_option=""
fi

SCRIPT_PATH=$(realpath)
CONFIG_PATH="${SCRIPT_PATH}"/config

menu_message="Select a HashiCorp Packer build for VMware vSphere."

if [ "$debug_mode" = true ]; then
  menu_message+=" \e[31m(Debug Mode)\e[0m"
fi

menu_option_1() {
  INPUT_PATH="$SCRIPT_PATH"/builds/ubuntu/22-04-lts/

  echo -e "\nCONFIRM: Build a Ubuntu Server 22.04 LTS (cloud-init) Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Ubuntu Server 22.04 LTS (cloud-init) Template for VMware vSphere. ###
  echo "Building a Ubuntu Server 22.04 LTS (cloud-init) Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  PACKER_LOG=1 packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/network.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/linux-storage.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_2() {
  INPUT_PATH="$SCRIPT_PATH"/builds/rhel/8/

  echo -e "\nCONFIRM: Build a Red Hat Enterprise Linux 8 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Red Hat Enterprise Linux 8 Template for VMware vSphere. ###
  echo "Building a Red Hat Enterprise Linux 8 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  PACKER_LOG=1 packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/network.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/linux-storage.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/rhsm.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

menu_option_3() {
  INPUT_PATH="$SCRIPT_PATH"/builds/rhel/9/

  echo -e "\nCONFIRM: Build a Red Hat Enterprise Linux 9 Template for VMware vSphere?"
  echo -e "\nContinue? (y/n)"
  read -r REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi

  ### Build a Red Hat Enterprise Linux 9 Template for VMware vSphere. ###
  echo "Building a Red Hat Enterprise Linux 9 Template for VMware vSphere..."

  ### Initialize HashiCorp Packer and required plugins. ###
  echo "Initializing HashiCorp Packer and required plugins..."
  packer init "$INPUT_PATH"

  ### Start the Build. ###
  echo "Starting the build...."
  echo "packer build -force -on-error=ask $debug_option"
  PACKER_LOG=1 packer build -force -on-error=ask $debug_option \
      -var-file="$CONFIG_PATH/vsphere.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/build.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/ansible.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/proxy.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/common.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/network.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/linux-storage.pkrvars.hcl" \
      -var-file="$CONFIG_PATH/rhsm.pkrvars.hcl" \
      "$INPUT_PATH"

  ### Build Complete. ###
  echo "Build Complete."
}

press_enter() {
  cd "$SCRIPT_PATH"
  echo -n "Press Enter to continue."
  read -r
  clear
}

info() {
  echo "Copyright 2023-2024 Broadcom. All Rights Reserved."
  echo "License: BSD-2"
  echo ""
  echo "GitHub Repository: github.com/vmware-samples/packer-examples-for-vsphere/"
  read -r
}

incorrect_selection() {
  echo "Invalid selection, please try again."
}

until [ "$selection" = "0" ]; do
  clear
  echo ""
  echo -e "$menu_message"
  echo ""
  echo "      Linux Distribution:"
  echo ""
  echo "    	 1  -  Ubuntu Server 22.04 LTS (cloud-init)"
  echo "    	 2  -  Red Hat Enterprise Linux 8"
  echo "    	 3  -  Red Hat Enterprise Linux 9"
  echo ""
  echo "      Other:"
  echo ""
  echo "        I   -  Information"
  echo "        Q   -  Quit"
  echo ""
  read -r selection
  echo ""
  case $selection in
    1 ) clear ; menu_option_1 ; press_enter ;;
    2 ) clear ; menu_option_2 ; press_enter ;;
    3 ) clear ; menu_option_3 ; press_enter ;;
    i|I ) clear ; info ; press_enter ;;
    q|Q ) clear ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done