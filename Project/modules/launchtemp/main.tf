# AMI for frontend
data "aws_ami" "frontend_ami" {
  most_recent = true
  owners      = ["590183907926"] # Use 'self' if using own AMI

  filter {
    name   = "name"
    values = ["frontend-ami"]
  }
}

# Launch Template - Frontend
resource "aws_launch_template" "frontend" {
  name          = "project-frontend_lt"
  description   = var.frontend_lt_desc
  image_id      = data.aws_ami.frontend_ami.id
  instance_type = var.frontend_instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.frontend_sg]
  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.frontend_lt_tag
    }
  }
}

# AMI for backend
data "aws_ami" "backend_ami" {
  most_recent = true
  owners      = ["590183907926"] # Use 'self' if using own AMI

  filter {
    name   = "name"
    values = ["backend-ami"]
  }
}

# Launch Template - Backend
resource "aws_launch_template" "backend" {
  name          = "project-backend_lt"
  description   = var.backend_lt_desc
  image_id      = data.aws_ami.backend_ami.id
  instance_type = var.backend_instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.backend_sg]
  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.backend_lt_tag
    }
  }
}
