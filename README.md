<!--
Copyright 2023-2024 Broadcom. All rights reserved.
SPDX-License-Identifier: BSD-2
-->

<!-- markdownlint-disable first-line-h1 no-inline-html -->

# Simple VM Packer and Creator for VMware vSphere

This repository provides a collection of opinionated examples that demonstrate how you can use both [HashiCorp Packer][packer] and the [Packer Plugin for VMware vSphere][packer-plugin-vsphere] (`vsphere-iso` builder) to automate the creation of virtual machine images for VMware vSphere environments. This project is a simplified and personalized clone of [Packer Examples for vSphere][packer-examples-for-vsphere].

# How to use

* First, make changes to the configuration files according to your needs...
* Then, simply run build.sh and select your operating system. This will create Content Library OVF templates.
* Then, with the help of terraform you can create multiple virtual machines from one cli.
* So by the help of the packer image you can create and deploy multiple virtual machines quickly.



This project supports the following guest operating systems:

## Linux Distributions


| Operating System         | Version   |
| :------------------------- | :---------- |
| Ubuntu Server            | 22.04 LTS |
| Red Hat Enterprise Linux | 8         |
| Red Hat Enterprise Linux | 9         |

## Support

This project is **not supported** by VMware Support Services.

## License

Copyright 2023-2024 Broadcom. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[//]: Links
[packer]: https://www.packer.io
[packer-plugin-vsphere]: https://developer.hashicorp.com/packer/plugins/builders/vsphere/vsphere-iso
[packer-examples-for-vsphere]: https://github.com/vmware-samples/packer-examples-for-vsphere
