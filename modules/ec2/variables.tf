variable "ami" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "security_group_ids" {
  type = list(string)
}
variable "key_name" {}

variable "env_name" {
  description = "Nombre del entorno"
  type        = string
}

variable "iam_instance_profile" {
  description = "Nombre del IAM Instance Profile a asociar con la instancia EC2"
  type        = string
  default     = null
}

