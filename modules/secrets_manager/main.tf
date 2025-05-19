resource "aws_secretsmanager_secret" "this" {
  name        = "${var.secret_name}-${var.env_name}"
  description = var.description
  tags = {
    Name        = "${var.secret_name}-${var.env_name}"
    Environment = var.env_name
  }
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_string
}
