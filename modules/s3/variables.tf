variable "bucket_name" {
  description = "Nombre base del bucket S3 (se agregará el sufijo del entorno)"
  type        = string
}

variable "env_name" {
  description = "Nombre del entorno (dev, qa, prod)"
  type        = string
}

variable "enable_versioning" {
  description = "Habilitar versionado en el bucket"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Permite eliminar el bucket incluso si tiene objetos"
  type        = bool
  default     = true
}


variable "region" {
  description = "Región donde crear el bucket S3"
  type        = string
  default     = "us-east-2"
}

variable "enable_lifecycle" {
  description = "Habilita reglas de ciclo de vida en el bucket"
  type        = bool
  default     = false
}

variable "noncurrent_days" {
  description = "Días para eliminar versiones anteriores de objetos"
  type        = number
  default     = 30
}

variable "expiration_days" {
  description = "Días para eliminar objetos no versionados"
  type        = number
  default     = 90
}

