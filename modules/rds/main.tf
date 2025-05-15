resource "aws_db_instance" "this" {
  allocated_storage    = var.allocated_storage
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.instance_class
  identifier           = "${var.db_name}-${var.env_name}"   # Nombre del recurso en AWS
  db_name              = var.db_name                        # Nombre de la BD interna

  username             = var.username
  password             = var.password
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.security_group_ids
  skip_final_snapshot  = true
  publicly_accessible  = false

  tags = {
    Name        = "${var.db_name}-${var.env_name}"
    Environment = var.env_name
  }
}


resource "aws_db_subnet_group" "this" {
  name       = "db-subnet-group-${var.env_name}"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "db-subnet-group-${var.env_name}"
  }
}
