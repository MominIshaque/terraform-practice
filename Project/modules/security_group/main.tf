# Bastion Host SG
resource "aws_security_group" "bastion-host" {
  name        = var.bastion_sg_name
  description = var.bastion_sg_desc
  vpc_id      = var.vpc_id
  depends_on  = [var.vpc_id]

  ingress {
    description = var.ssh_desc
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.allow_all]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allow_all]
  }

  tags = {
    Name = var.bastion_sg_tag
  }
}

# ALB Frontend SG
resource "aws_security_group" "alb-frontend-sg" {
  name        = var.alb_frontend_name
  description = var.alb_frontend_desc
  vpc_id      = var.vpc_id
  depends_on  = [var.vpc_id]

  ingress {
    description = var.http_desc
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.allow_all]
  }

  ingress {
    description = var.https_desc
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = [var.allow_all]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allow_all]
  }

  tags = {
    Name = var.alb_frontend_tag
  }
}

# ALB Backend SG
resource "aws_security_group" "alb-backend-sg" {
  name        = var.alb_backend_name
  description = var.alb_backend_desc
  vpc_id      = var.vpc_id
  depends_on  = [var.vpc_id]

  ingress {
    description = var.http_desc
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.allow_all]
  }

  ingress {
    description = var.https_desc
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = [var.allow_all]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allow_all]
  }

  tags = {
    Name = var.alb_backend_tag
  }
}

# Frontend Server SG
resource "aws_security_group" "frontend-server-sg" {
  name        = var.frontend_sg_name
  description = var.frontend_sg_desc
  vpc_id      = var.vpc_id
  depends_on  = [var.vpc_id, aws_security_group.alb-frontend-sg]

  ingress {
    description = var.http_desc
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.allow_all]
  }

  ingress {
    description = var.ssh_desc
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.allow_all]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allow_all]
  }

  tags = {
    Name = var.frontend_sg_tag
  }
}

# Backend Server SG
resource "aws_security_group" "backend-server-sg" {
  name        = var.backend_sg_name
  description = var.backend_sg_desc
  vpc_id      = var.vpc_id
  depends_on  = [var.vpc_id, aws_security_group.alb-backend-sg]

  ingress {
    description = var.http_desc
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.allow_all]
  }

  ingress {
    description = var.ssh_desc
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.allow_all]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allow_all]
  }

  tags = {
    Name = var.backend_sg_tag
  }
}

# RDS SG
resource "aws_security_group" "book-rds-sg" {
  name        = var.rds_sg_name
  description = var.rds_sg_desc
  vpc_id      = var.vpc_id
  depends_on  = [var.vpc_id]

  ingress {
    description = var.mysql_desc
    from_port   = var.mysql_port
    to_port     = var.mysql_port
    protocol    = "tcp"
    cidr_blocks = [var.allow_all]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allow_all]
  }

  tags = {
    Name = var.rds_sg_tag
  }
}
