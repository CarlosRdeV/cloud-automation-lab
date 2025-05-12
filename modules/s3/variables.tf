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
  default     = false
}


variable "region" {
  description = "Región donde crear el bucket S3"
  type        = string
  default     = "us-east-2"
}


