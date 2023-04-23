variable "os_image_source" {
  description = "The name of the base OS image to use."
  type        = string
  default     = "/var/lib/libvirt/images/CentOS-Stream-GenericCloud-8-20230404.0.x86_64.qcow2"
}

variable "base_volume_name" {
  description = "The name of the base volume for storage."
  type        = string
  default     = "resize_disk"
}

variable "base_pool_name" {
  description = "The name of the base storage pool."
  type        = string
  default     = "default"
}

variable "volume_size" {
  description = "The size of the virtual machine's disk volume (in bytes)."
  type        = number
  default     = "10"
}

variable "hostname_prefix" {
  description = "The hostname for the virtual machine."
  type        = string
  default     = "host"
}

variable "memory" {
  description = "The amount of memory (in MB)"
  type        = number
  default     = 1024
}

variable "vcpu" {
  description = "The number of virtual CPUs"
  type        = number
  default     = 1
}

variable "libvirt_uri" {
  description = "Uri for connecting to the libvirt host"
  type        = string
  default     = "qemu:///system"
}

variable "vm_count" {
  description = "Count of machine domains"
  type        = number
  default     = 1
}

variable "ssh_pub_key" {
  description = "SSH public key"
  default     = "~/.ssh/id_rsa.pub"
  type        = string
}

variable "username" {
  description = "Username for authentication"
  type        = string
  default     = "theintegrative"

}

variable "password_hash" {
  description = "Hashed password for authentication"
  type        = string
  default     = "$6$rounds=4096$WS5OW49rZ7wd68mE$aCoaY7Cz4YXd74eoByEA0dxOxQnuTTx8voadkaxNnoCAVXqbW63Wm3cysjISF0E6tlXJIXjZSNrDOVwjWTWJQ1"
}
