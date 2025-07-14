resource "aws_instance" "name" {
  ami           = "ami-0c803b171269e2d72"
  key_name      = "ohio-key"
  instance_type = "t2.micro"
  tags = {
    Name = "hi from terraform"
  }
}
