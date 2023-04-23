module "vm" {
  vm_count        = 2
  source          = "./vm"
  volume_size     = 20
  hostname_prefix = "my_centos_8_box"
  memory          = 2048
  vcpu            = 2
  libvirt_uri     = "qemu+ssh://theintegrative@192.168.2.9/system?keyfile=/home/theintegrative/.ssh/id_rsa&sshauth=privkey"
  ssh_pub_key     = "~/.ssh/id_rsa.pub"
  username        = "theintegrative"
  password_hash   = "$6$rounds=4096$WS5OW49rZ7wd68mE$aCoaY7Cz4YXd74eoByEA0dxOxQnuTTx8voadkaxNnoCAVXqbW63Wm3cysjISF0E6tlXJIXjZSNrDOVwjWTWJQ1"
}

output "vm" {
  value = module.vm
}
