variable "env_name" {
  description = "Nombre del entorno (dev, qa, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará el ALB"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs de subredes públicas donde se colocará el ALB"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Lista de Security Groups asociados al ALB"
  type        = list(string)
}
