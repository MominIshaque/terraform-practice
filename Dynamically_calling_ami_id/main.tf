# Fetching latest Amazon Linux 2 AMI dynamically
data "aws_ami" "latest" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

# Creating EC2 instance
resource "aws_instance" "Server1" {
  ami           = data.aws_ami.latest.id
  instance_type = var.instance_type

  tags = {
    Name = "Hi from terraform"
  }
}

# Saving public and private IPs to file
resource "local_file" "ip_output" {
  filename = "instance-ips.txt"
  content  = <<EOT
Public IP: ${aws_instance.Server1.public_ip}
Private IP: ${aws_instance.Server1.private_ip}
EOT
}
