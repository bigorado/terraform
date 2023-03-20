output "yandex_compute_instance" {
    value = yandex_compute_instance.platform.network_interface[0].nat_ip_address
}

output "yandex_compute_instance2" {
    value = yandex_compute_instance.platform2.network_interface[0].nat_ip_address
}
