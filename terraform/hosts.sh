#! /bin/bash
IP_ADDRESS=$(terraform output -json ip | jq -r ".")
# create hosts file with jump
echo "[ubuntu-terraform]" > home_1_hosts.ini
echo "$IP_ADDRESS ansible_user=theintegrative ansible_ssh_common_args='-J home-1'" >> home_1_hosts.ini
# create ssh jump file
echo "#! /bin/bash" > ssh_jump.sh
echo "ssh -J home-1 theintegrative@$IP_ADDRESS" >> ssh_jump.sh
