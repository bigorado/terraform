#locals {
#  vm_web = "${ var.vm_web_inst }"
#  vm_db= "${ var.vm_db_inst }"
#}

locals {
  vm_web = "netology-${ var.develop }-platform-web"
  vm_db= "netology-${ var.develop }-platform-db"
}
