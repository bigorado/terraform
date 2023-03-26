locals {
  ssh_key_contents = filebase64(var.ssh_key)
  vm1_external_ip = yandex_compute_instance.platform[0].network_interface.0.nat_ip_address
  vm2_external_ip = yandex_compute_instance.platform[1].network_interface.0.nat_ip_address
}