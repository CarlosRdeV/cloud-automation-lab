variable "vpc_id" {}
variable "sg_name" {
  default = "allow-ssh-http"
}
variable "description" {
  default = "Allow SSH and HTTP inbound traffic"
}

variable "env_name" {
  description = "Nombre del entorno"
  type        = string
}
