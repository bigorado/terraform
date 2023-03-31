resource "yandex_compute_instance" "vms" {
  for_each = { for vm in var.vm : vm.vm_name => vm }
#  for_each = "vm-${var.vm}"
  name     = each.key
#  zone     = each.value.zone

  resources {
    cores  = 2
    memory = 6
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = 14
    }
  }

  network_interface {
    subnet_id           = yandex_vpc_subnet.develop.id
#    subnet_id           = yandex_vpc_subnet.develop["${each.value.subnet}"].id
#    security_group_ids = ["${yandex_vpc_security_group.webservers-sg.id}"]
  }

  metadata = {
    serial-port-enable = var.vm_metadata.serial-port-enable
    ssh-keys           = "ubuntu:${local.ssh_key}"
  }
}