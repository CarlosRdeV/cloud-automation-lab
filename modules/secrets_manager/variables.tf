variable "secret_name" {
  description = "Nombre base del secreto (se le agrega el sufijo del entorno)"
  type        = string
}

variable "secret_string" {
  description = "Contenido del secreto (ej. JSON con usuario y contraseña)"
  type        = string
}

variable "description" {
  description = "Descripción del secreto"
  type        = string
  default     = "Secreto gestionado por Terraform"
}

variable "env_name" {
  description = "Nombre del entorno (dev, qa, prod)"
  type        = string
}
