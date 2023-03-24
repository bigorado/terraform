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

#Мои переменные

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


variable "vm_web_resources" {
  type = map
  default = {
    cores          = 2
    memory         = 1
    core_fraction  = 5
  }
}

variable "vm_metadata" {
  type = map
  default = {
    serial-port-enable = 1
    ssh-key            = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDSFLz5Ihh8FI+W2VZSFyIj5qEEbb/A3hQykKWjK2sth"
  }
}
