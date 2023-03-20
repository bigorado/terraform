resource "yandex_vpc_network" "develop2" {
  name = var.vpc_name2
}
resource "yandex_vpc_subnet" "develop2" {
  name           = var.vpc_name2
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr2
}


data "yandex_compute_image" "ubuntu2" {
  family = "${var.vm_db_os}"
}
resource "yandex_compute_instance" "platform2" {
  name        = "${var.vm_db_inst}"
  platform_id = "${var.vm_db_platf}"
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
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
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}
