resource "aws_instance" "web" {
  ami                    = "ami-0c02fb55956c7d316" # Ubuntu 20.04 LTS en us-east-1
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.ssh.id]
  key_name               = aws_key_pair.deployer.key_name

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
