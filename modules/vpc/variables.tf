variable "vpc_cidr_block" {}
variable "subnet_cidr_block" {}
variable "availability_zone" {}
variable "vpc_name" {}
variable "subnet_name" {}
variable "env_name" {
  description = "Nombre del entorno"
  type        = string
}
