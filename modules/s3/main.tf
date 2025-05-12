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
