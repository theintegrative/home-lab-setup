terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = "qemu+ssh://theintegrative@192.168.2.9/system?keyfile=/home/theintegrative/.ssh/id_rsa&sshauth=privkey"
}

# resource
resource "libvirt_volume" "os_image_ubuntu" {
  name   = "os_image_ubuntu"
  pool   = "default"
  source = "https://cloud-images.ubuntu.com/releases/xenial/release/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
}

resource "libvirt_volume" "disk_ubuntu_resized" {
  name           = "disk"
  base_volume_id = libvirt_volume.os_image_ubuntu.id
  pool           = "default"
  # 20GB
  size = 20000000000
}

resource "libvirt_cloudinit_disk" "cloudinit_ubuntu_resized" {
  name           = "cloudinit_ubuntu_resized.iso"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = "default"
}

resource "libvirt_domain" "domain-ubuntu" {
  name   = "ubuntu-terraform"
  memory = "2512"
  vcpu   = 2
  xml {
    xslt = file("${path.module}/replace-type.xml")
  }

  cloudinit = libvirt_cloudinit_disk.cloudinit_ubuntu_resized.id

  network_interface {
    network_name = "default"
    wait_for_lease = true
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.disk_ubuntu_resized.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

resource "null_resource" "configurator" {
  depends_on = [libvirt_domain.domain-ubuntu]
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "./${path.module}/hosts.sh"
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ./home_1_hosts.ini ${path.module}/../ansible/terraform.yml"
  }
}

# data
data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}

# output
output "ip" {
  value = libvirt_domain.domain-ubuntu.network_interface.0.addresses.0
}
