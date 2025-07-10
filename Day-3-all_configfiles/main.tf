resource "aws_instance" "Server1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = "Hi from terraform"
  }

}

