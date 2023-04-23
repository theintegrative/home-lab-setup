resource "libvirt_volume" "os_image" {
  count  = var.vm_count
  name   = "${var.hostname_prefix}_os_image_${count.index}"
  pool   = var.base_pool_name
  source = var.os_image_source
}

resource "libvirt_volume" "resize_disk" {
  count          = var.vm_count
  name           = "${var.hostname_prefix}_disk_${count.index}"
  base_volume_id = libvirt_volume.os_image[count.index].id
  pool           = var.base_pool_name
  size           = var.volume_size * 1000000000

}

# Use CloudInit to add our ssh-key to the instance
resource "libvirt_cloudinit_disk" "cloudinit_resized" {
  count          = var.vm_count
  name           = "${var.hostname_prefix}_cloudinit_${count.index}.iso"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = var.base_pool_name
}
