variable "vpc_cidr_block" {
  description = "Bloque CIDR principal para la VPC"
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "Lista de bloques CIDR para subnets en diferentes AZs (mínimo 2)"
  type        = list(string)
}

variable "region" {
  description = "Región AWS donde se creará la infraestructura (ej. us-east-1)"
  type        = string
}

variable "vpc_name" {
  description = "Nombre base de la VPC"
  type        = string
}

variable "subnet_name" {
  description = "Nombre base para las subnets"
  type        = string
}

variable "env_name" {
  description = "Nombre del entorno (dev, qa, prod)"
  type        = string
}
