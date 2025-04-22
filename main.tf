provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_demo_bucket" {
  bucket = "cloud-automation-lab-demo-bucket-${random_id.bucket_suffix.hex}"
  force_destroy = true
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}
