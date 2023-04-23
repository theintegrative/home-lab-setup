terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
  }
}

provider "libvirt" {
  uri = var.libvirt_uri
}

# cloud-init
data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
  vars = {
    ssh_pub_key   = data.local_file.ssh_pub_key.content
    username      = var.username
    password_hash = var.password_hash
  }
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}

data "local_file" "ssh_pub_key" {
  filename = pathexpand(var.ssh_pub_key)
}

resource "libvirt_domain" "machine" {
  count  = var.vm_count
  name   = "${var.hostname_prefix}_${count.index}"
  memory = var.memory
  vcpu   = var.vcpu

  cloudinit = libvirt_cloudinit_disk.cloudinit_resized[count.index].id

  network_interface {
    network_name   = "default"
    wait_for_lease = true
  }

  xml {
    xslt = file("${path.module}/replace-type.xml")
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
    volume_id = libvirt_volume.resize_disk[count.index].id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
