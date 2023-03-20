#output "develop" {
#  value = yandex_vpc_network.develop.id.network_interface.0.nat_ip_address
#}

#output "external_ip" {
#  value = network_interface_0.nat_ip_address
#}

output "default_instance_public_ip" {
    value = yandex_compute_instance.default.network_interface[0].nat_ip_address
}