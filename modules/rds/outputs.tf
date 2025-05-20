output "db_instance_endpoint" {
  description = "Endpoint de conexión de la base de datos"
  value       = aws_db_instance.this.endpoint
}

output "db_instance_port" {
  description = "Puerto de conexión de la base de datos"
  value       = aws_db_instance.this.port
}

output "db_instance_name" {
  description = "Nombre de la base de datos creada"
  value       = aws_db_instance.this.db_name
}

output "db_instance_arn" {
  description = "ARN completo de la instancia RDS"
  value       = aws_db_instance.this.arn
}
