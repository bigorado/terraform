###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

#variable "vpc_name2" {
#  type        = string
#  default     = "develop2"
#  description = "VPC network&subnet name"
#}


#Мои переменные

variable "security_group" {
  type        = string
  default     = "enpbksq984ap23csol2u"
  description = "Security Group"
}

variable "vm_web_os" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu-2004-lts"
}

variable "vm_web_inst" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "netology-develop-platform-web"
}

variable "vm_web_platf" {
  type        = string
  default     = "standard-v1"
  description = "standard-v1"
}


variable "vm_metadata" {
  type = map
  default = {
    serial-port-enable = 1
#    ssh-keys = file("${path.module}/id_ed25519.pub")
#    ssh-key            = local.sshkey
#    ssh-key            = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDSFLz5Ihh8FI+W2VZSFyIj5qEEbb/A3hQykKWjK2sth"
  }
}

variable "ssh_key" {
  type        = string
  description = "Path to the ssh key file"
  default     = "~/.ssh/id_ed25519"
}


#Переменные с ресурсами машин
variable "vm_resources" {
  type = map
  default = {
    cores          = 2
    memory         = 2
    core_fraction  = 5
  }
}

variable "vm" {
  type        = map(any)
  default = {
   vm1 = {
      zone     = "ru-central1-a"
      subnet   = "subnet"
    },
    vm2 = {
      zone     = "ru-central1-b"
      subnet   = "subnet"
    }
  }
}

#variable "vms" {
#  type = list(object({
#    vm_name = string
#    cpu     = number
#    ram     = number
#    disk    = number
#  }))
#  default = [
#    {
#      vm_name = "vm1"
#      cpu     = 2
#      ram     = 2
#      disk    = 5
#    },
#    {
#      vm_name = "vm2"
#      cpu     = 2
#      ram     = 4
#      disk    = 7
#    }
#  ]
#}