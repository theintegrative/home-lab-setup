#! /bin/bash
IMAGE_FILE="CentOS-Stream-GenericCloud-8-20220913.0.x86_64.qcow2"
IMAGE_DIR="/var/lib/libvirt/images/"
IMAGE_URL="https://cloud.centos.org/centos/8-stream/x86_64/images/CentOS-Stream-GenericCloud-8-20220913.0.x86_64.qcow2"

get_vm_ip() {
  IP_ADDRESS=$(terraform output -json vm | jq -r ".ip[$1][0]")
}

download_image() {
  if [ ! -f "$IMAGE_DIR$IMAGE_FILE" ]; then
	cd $IMAGE_DIR
	wget $IMAGE_URL
  fi
}

create_hosts_file() {
  echo "[ubuntu-terraform]" > home_1_hosts.ini
  echo "$IP_ADDRESS ansible_user=theintegrative ansible_ssh_common_args='-J home-1'" >> home_1_hosts.ini
}

create_ssh_jump_script() {
  echo "#! /bin/bash" > ssh_jump
  echo "ssh -J home-1 theintegrative@$IP_ADDRESS" >> ssh_jump
  chmod +x ssh_jump
}
