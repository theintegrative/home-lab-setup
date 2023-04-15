# Home lab setup using ansible 

Here you can see all my basic configurations using ansible for my homelab servers. For these I repurposed used hardware.

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
- ansible

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

Generate a password hash:
``` shell
mkpasswd --method=SHA-512 --rounds=4096 | xclip -sel clip
```

## Authors
- The Integrative: [Website](https://github.com/theintegrative)
