provider "aws" {
  region = "us-east-2"
}

# ✅ Fetch default VPC
data "aws_vpc" "default" {
  default = true
}

# ✅ Security Group inside default VPC
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow all traffic for testing"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebServerSecurityGroup"
  }
}

# ✅ Fetch latest Amazon Linux 2 AMI
data "aws_ami" "latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

# ✅ Launch EC2 instance with correct SG and AMI
resource "aws_instance" "web" {
  ami                    = data.aws_ami.latest.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data              = file("shelscript.sh") # Ensure this file exists in same dir

  tags = {
    Name = "WebServerWithExternalUserData"
  }
}

output "ip_address" {
  value = aws_instance.web.public_ip
}
