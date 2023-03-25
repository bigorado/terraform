resource "yandex_vpc_network" "network" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "subnet" {
#  for_each      = var.vms
  name          = var.vpc_name
  network_id    = yandex_vpc_network.network.id
  zone          = var.default_zone
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_compute_instance" "vm" {
  for_each = {
    for idx, vm in var.vms : vm.vm_name => {
      name  = "vm-${vm.vm_name}"
      cpu   = vm.cpu
      ram   = vm.ram
      disk  = vm.disk
    }
  }

#  name           = each.value.name
#  platform_id    = var.vm_web_platf
#  boot_disk_size = each.value.disk

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
    ssh-keys           = local.sshkey
#   ssh-keys           = var.vm_metadata.ssh-key
  }

  depends_on = [yandex_compute_instance.platform[0]]

}