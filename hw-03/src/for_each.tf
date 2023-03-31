resource "yandex_compute_instance" "vms" {
  depends_on = [yandex_compute_instance.platform]
  for_each = { for vm in var.vm : vm.vm_name => vm }
  name     = each.key

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
    nat = true
  }

  metadata = {
    serial-port-enable = var.vm_metadata.serial-port-enable
    ssh-keys           = "ubuntu:${local.ssh_key}"
  }
}