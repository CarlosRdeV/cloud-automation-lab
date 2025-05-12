variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key to access EC2"
  default     = "ec2-key"
}

variable "env_name" {
  description = "Nombre del entorno (dev, qa, prod)"
  type        = string
}


