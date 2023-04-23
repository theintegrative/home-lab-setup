# Home lab setup using ansible 

Here you can see all my basic configurations for my homelab servers. For these I repurposed used hardware.

## Table of Contents

- [Getting Started](#getting-started)
  - [Hardware](#hardware)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Authors](#authors)

## Getting Started

This is the current state how the homelab is configured. 

### Hardware

Laptop: (home-0) 
- os: Ubuntu server
- cpu: Intel i3-6006U (4) @ 2.000GHz
- gpu: Intel Skylake GT2 [HD Graphics 520] 
- memory: 11886MiB          
- disk: 98G

PC: (home-1)
- os: Ubuntu server
- cpu: AMD FX-8350 (8) @ 4.000GHz
- gpu: AMD ATI Radeon 3000 
- memory: 329MiB / 15729MiB 
- disk: 117G

### Prerequisites
This setup is tested using ansible from an ubuntu host

Packages:
- [ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [terraform](https://developer.hashicorp.com/terraform/downloads)
- [virt-manager](https://virt-manager.org/)

### Installation

Clone the repo
``` shell
git clone git@github.com:theintegrative/home-lab-setup-ansible.git
```

## Usage

Setting up the main node:
```
ansible-playbook -i ansible/homelab -bK ansible/playbooks/main.yml
```

Setting up the worker node:
```shell
terraform init
terraform apply
```

## Configuration

### Terraform
Inside `./terraform/vm/variables.tf`:
| Variable Name     | Description                            | Type   | Default Value                                                                               |
|-------------------|----------------------------------------|--------|---------------------------------------------------------------------------------------------|
| os_image_source   | The name of the base OS image to use   | string | "/var/lib/libvirt/images/CentOS-Stream-GenericCloud-8-20230404.0.x86_64.qcow2"              |
| base_volume_name  | The name of the base volume for storage | string | "resize_disk"                                                                                |
| base_pool_name    | The name of the base storage pool       | string | "default"                                                                                    |
| volume_size       | The size of the virtual machine's disk volume (in bytes) | number | 10                                                            |
| hostname_prefix   | The hostname for the virtual machine  | string | "host"                                                                                       |
| memory            | The amount of memory (in MB)          | number | 1024                                                                                         |
| vcpu              | The number of virtual CPUs            | number | 1                                                                                            |
| libvirt_uri       | Uri for connecting to the libvirt host | string | "qemu:///system"                                                                             |
| vm_count          | Count of machine domains               | number | 1                                                                                            |
| ssh_pub_key       | SSH public key                         | string | "~/.ssh/id_rsa.pub"                                                                          |
| username          | Username for authentication            | string | "theintegrative"                                                                             |
| password_hash     | Hashed password for authentication     | string | "$6$rounds=4096$WS5OW49rZ7wd68mE$aCoaY7Cz4YXd74eoByEA0dxOxQnuTTx8voadkaxNnoCAVXqbW63Wm3cysjISF0E6tlXJIXjZSNrDOVwjWTWJQ1" |



Example `main.tf`:
``` terraform
module "vm" {
  source = "./vm"
  os_image_source  = 
  base_volume_name = 
  base_pool_name   = 
  volume_size      = 
  hostname_prefix  = 
  memory           = 
  vcpu             = 
  libvirt_uri      = 
  vm_count         = 
  ssh_pub_key   = 
  username         = 
  password_hash    =
}
```


Generate a password hash:
``` shell
mkpasswd --method=SHA-512 --rounds=4096 | xclip -sel clip
```

## Authors
- The Integrative: [Website](https://github.com/theintegrative)
