resource "aws_s3_bucket" "this" {
  provider      = aws  # ¡NO aws.s3 aquí!
  bucket        = "${var.bucket_name}-${var.env_name}"
  force_destroy = var.force_destroy
  

  tags = {
    Name        = "${var.bucket_name}-${var.env_name}"
    Environment = var.env_name
  }

}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = var.enable_lifecycle ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "lifecycle-rule"
    status = "Enabled"

    filter {
      and {}  # 👈 Aplica a todo el bucket sin restricciones
    }

    expiration {
      days = var.expiration_days
    }

    noncurrent_version_expiration {
      newer_noncurrent_versions = 1
      noncurrent_days           = var.noncurrent_days
    }
  }
}



