variable "engine" {}
variable "engine_version" {}
variable "instance_class" {}
variable "db_name" {}
variable "username" {}
variable "password" {}

variable "allocated_storage" {
  default = 20
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "env_name" {
  description = "Nombre del entorno"
  type        = string
}
