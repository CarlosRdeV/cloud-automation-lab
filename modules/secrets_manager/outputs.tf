output "secret_id" {
  description = "ID del secreto creado"
  value       = aws_secretsmanager_secret.this.id
}

output "secret_arn" {
  description = "ARN del secreto"
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_name" {
  description = "Nombre completo del secreto"
  value       = aws_secretsmanager_secret.this.name
}
