output "ip" {
  value = libvirt_domain.machine[*].network_interface.0.addresses
}
