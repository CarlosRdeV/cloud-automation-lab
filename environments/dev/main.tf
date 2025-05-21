provider "aws" {
  alias  = "s3"
  region = "us-east-2"
}


module "vpc" {
  source              = "../../modules/vpc"
  vpc_cidr_block      = "10.0.0.0/16"
  subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24"]
  region              = "us-east-1"
  vpc_name            = "main-vpc"
  subnet_name         = "main-subnet"
  env_name            = var.env_name
}


module "security_group" {
  source      = "../../modules/security_group"
  vpc_id      = module.vpc.vpc_id
  sg_name     = "allow-ssh-http"
  description = "Allow SSH and HTTP traffic"
  env_name    = var.env_name 
}

module "ec2" {
  source             = "../../modules/ec2"
  ami                = "ami-04505e74c0741db8d"
  instance_type      = "t2.micro"
  subnet_id          = module.vpc.subnet_ids[0]  # ✅ Ajustado
  key_name           = aws_key_pair.deployer.key_name
  security_group_ids = [module.security_group.security_group_id]
  env_name           = var.env_name  

  iam_instance_profile = module.iam_ec2_role.instance_profile_name
}

module "alb" {
  source              = "../../modules/alb"
  env_name            = var.env_name
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.subnet_ids
  security_group_ids  = [module.security_group.security_group_id]
}


resource "aws_lb_target_group_attachment" "ec2_attachment" {
  target_group_arn = module.alb.target_group_arn
  target_id        = module.ec2.instance_id
  port             = 80
}


module "s3" {
  source            = "../../modules/s3"
  bucket_name       = "app-storage-crive"  
  env_name          = var.env_name
  enable_versioning = true
  force_destroy     = false

  enable_lifecycle  = true
  noncurrent_days   = 15
  expiration_days   = 60
  
  providers = {
    aws = aws.s3  
  }
}


module "iam_ec2_role" {
  source              = "../../modules/iam"
  role_name           = "ec2-role-${var.env_name}"
  env_name            = var.env_name

  assume_role_policy  = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]

  custom_policy_name = "access-s3-dev"
  custom_policy_json = local.ec2_s3_access_policy

}

locals {
  
  s3_bucket_name = "${var.bucket_name}-${var.env_name}"

  ec2_s3_access_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket"
        ],
        Resource = "arn:aws:s3:::${local.s3_bucket_name}"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = "arn:aws:s3:::${local.s3_bucket_name}/*"
      }
    ]
  })
}

module "db_secret" {
  source      = "../../modules/secrets_manager"
  secret_name = "mysql-credentials"
  env_name    = var.env_name
  description = "Credenciales de acceso para RDS MySQL en ${var.env_name}"

  secret_string = jsonencode({
    username = "admin"
    password = "SuperClaveSegura123"
  })
}

data "aws_secretsmanager_secret_version" "mysql_credentials" {
  secret_id = "mysql-credentials-${var.env_name}"

  depends_on = [
    module.db_secret
  ]
}

locals {
  mysql_credentials = jsondecode(data.aws_secretsmanager_secret_version.mysql_credentials.secret_string)
}


module "rds" {
  source              = "../../modules/rds"
  
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  db_name             = "basedatos"
  username            = local.mysql_credentials.username
  password            = local.mysql_credentials.password
  allocated_storage   = 20
  subnet_ids          = module.vpc.subnet_ids  
  security_group_ids  = [module.security_group.security_group_id]
  env_name            = var.env_name
}

