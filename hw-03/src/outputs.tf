output "platfom" {
    value = yandex_compute_instance.platform[*].network_interface[0].nat_ip_address
}

#output "vm" {
#    value = yandex_compute_instance.vm[*].network_interface[0].nat_ip_address
#}
