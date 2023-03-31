output "platfom" {
    value = yandex_compute_instance.platform[*].network_interface[0].nat_ip_address
}

output "vms" {
    value = yandex_compute_instance.vms[*].network_interface[0].nat_ip_address
}
