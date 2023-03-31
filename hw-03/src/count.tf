#Count

data "yandex_compute_image" "ubuntu" {
  family = "${var.vm_web_os}"
}
resource "yandex_compute_instance" "platform" {
  count = 2
  name        = "${var.vm_web_inst}-${count.index}"
  platform_id = "${var.vm_web_platf}"
resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
    core_fraction = var.vm_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat       = true
  }

  metadata = {
#    serial-port-enable = var.vm_metadata.serial-port-enable
    ssh-keys           = "ubuntu:${local.ssh_key}"
  }
}
