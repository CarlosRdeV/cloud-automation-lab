provider "aws" {
  alias  = "s3"
  region = "us-east-2"
}


module "vpc" {
  source            = "../../modules/vpc"
  vpc_cidr_block    = "10.0.0.0/16"
  subnet_cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  vpc_name          = "main-vpc"
  subnet_name       = "main-subnet"
  env_name           = var.env_name
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
  subnet_id          = module.vpc.subnet_id
  key_name           = aws_key_pair.deployer.key_name
  security_group_ids = [module.security_group.security_group_id]
  env_name           = var.env_name  
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


