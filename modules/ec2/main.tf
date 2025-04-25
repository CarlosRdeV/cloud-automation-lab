resource "aws_instance" "web" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = true  

  user_data = <<-EOF
              #!/bin/bash
              sleep 30
              apt-get update -y
              DEBIAN_FRONTEND=noninteractive apt-get install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "Hola desde tu EC2 con NGINX 🚀" > /var/www/html/index.html
              EOF

  tags = {
    Name = "terraform-ec2"
  }
}
