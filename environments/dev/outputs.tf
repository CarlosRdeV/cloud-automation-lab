output "instance_public_ip" {
  value = module.ec2.instance_public_ip
}

output "instance_id" {
  value = module.ec2.instance_id
}

output "alb_dns" {
  description = "DNS público del Application Load Balancer"
  value       = module.alb.alb_dns_name
}
