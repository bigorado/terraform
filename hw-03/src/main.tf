resource "yandex_vpc_network" "develop" {
  name = var.vpc_name

#resource "yandex_compute_instance_metadata" "ssh_keys" {
#  instance_id = yandex_compute_instance[*].id

}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

#Разобраться с инвентаризацией
#data "template_file" "inventory_file" {
#  template = "${file("${path.module}/inventory.tpl")}"
#}

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",
    { webservers1 =  yandex_compute_instance.platform
      webservers2 =  yandex_compute_instance.vm } )

  filename = "${abspath(path.module)}/hosts.cfg"
}

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
    ssh-keys           = local.ssh_key
#    ssh-keys           = var.vm_metadata.ssh-key
  }
}

#For_each

resource "yandex_compute_instance" "vm" {
  for_each = {
    for idx, vm in var.vms : vm.vm_name => {
      name  = "vm-${vm.vm_name}"
      cpu   = vm.cpu
      ram   = vm.ram
      disk  = vm.disk
    }
  }

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
 }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    serial-port-enable = var.vm_metadata.serial-port-enable
    ssh-keys           = local.ssh_key
#   ssh-keys           = var.vm_metadata.ssh-key
  }

  depends_on = [yandex_compute_instance.platform[0]]

}
