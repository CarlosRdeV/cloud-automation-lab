output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = [
    aws_subnet.a.id,
    aws_subnet.b.id
  ]
}

