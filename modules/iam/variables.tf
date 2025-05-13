variable "role_name" {
  description = "Nombre del rol IAM"
  type        = string
}

variable "assume_role_policy" {
  description = "Política de confianza en formato JSON"
  type        = string
}

variable "managed_policy_arns" {
  description = "Lista de ARNs de políticas gestionadas a adjuntar al rol"
  type        = list(string)
  default     = []
}

variable "env_name" {
  description = "Nombre del entorno (dev, qa, prod)"
  type        = string
}


