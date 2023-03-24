resource "yandex_compute_instance" "web" {
  for_each = toset([ 0, 1 ])
  name =
"${var.vm_web_inst}-${each.key}"
}

#Моё

data "yandex_compute_image" "ubuntu2" {
  family = "${var.vm_web_os}"
}
resource "yandex_compute_instance" "platform3" {
#  name        = "${local.vm_web}"
  platform_id = "${var.vm_web_platf}"
resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
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
    serial-port-enable = var.vm_metadata.serial-port-enable
    ssh-keys           = var.vm_metadata.ssh-key
  }
}

data "yandex_compute_image" "ubuntu3" {
  family = "${var.vm_web_os}"
}
resource "yandex_compute_instance" "platform" {
#  name        = "${local.vm_web}"
  platform_id = "${var.vm_web_platf}"
resources {
    cores         = 1
    memory        = 2
    core_fraction = 10
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
    serial-port-enable = var.vm_metadata.serial-port-enable
    ssh-keys           = var.vm_metadata.ssh-key
  }
}


