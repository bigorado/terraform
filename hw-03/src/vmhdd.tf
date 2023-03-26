resource "yandex_compute_disk" "disk_dop" {
  name        = "disk-${count.index + 1}"
  size        = 5
  zone        = var.default_zone
  count       = 3
}

resource "yandex_compute_instance" "vmhdd" {
  name         = "vmhdd"
  zone         = var.default_zone
  platform_id  = var.vm_web_platf
resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
    core_fraction = var.vm_resources.core_fraction
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }


  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk_dop.*.id
    content {
      device_name = "disk-${secondary_disk.key+1}"
      disk_id     = secondary_disk.value
    }
  }
}