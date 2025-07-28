provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web" {
  ami           = "ami-0eb9d6fc9fab44d24"  # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = "prodkey"         # Replace with your key

  user_data = file("install_httpd.sh")

  tags = {
    Name = "WebServer-With-ShellScript"
  }
}

output "public_ip" {
  value = aws_instance.web.public_ip
  description = "The public IP of the EC2 instance"
}
#hi
