output "role_name" {
  description = "Nombre del rol IAM creado"
  value       = aws_iam_role.this.name
}

output "role_arn" {
  description = "ARN del rol IAM creado"
  value       = aws_iam_role.this.arn
}

output "instance_profile_name" {
  description = "Nombre del instance profile asociado al rol"
  value       = aws_iam_instance_profile.this.name
}

output "custom_policy_arn" {
  description = "ARN de la política personalizada (si se crea)"
  value       = try(aws_iam_policy.custom[0].arn, null)
}

