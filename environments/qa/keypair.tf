resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file("${path.module}/../../keys/ec2-key.pub")
}
