resource "aws_instance" "back" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.public_subnet_1_id
  vpc_security_group_ids = [var.bastion_sg_id]

  tags = {
    Name = var.bastion_instance_name
  }
}
