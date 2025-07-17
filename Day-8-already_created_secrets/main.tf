# Create VPC
resource "aws_vpc" "RDS_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "momin-custom-vpc"
  }
}

# Create Subnets
resource "aws_subnet" "rds_subnets" {
  count             = length(var.subnet_cidrs)
  vpc_id            = aws_vpc.RDS_vpc.id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "rds-subnet-${count.index}"
  }
}

data "aws_availability_zones" "available" {}

# Create DB Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "custom-db-subnet-group"
  subnet_ids = aws_subnet.rds_subnets[*].id
  tags = {
    Name = "custom-db-subnet-group"
  }
}


# RDS Instance
resource "aws_db_instance" "rds" {
  identifier             = var.db_instance_identifier
  allocated_storage      = 20
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  username               = local.db_creds.username
  password               = local.db_creds.password
  db_name                = var.db_name
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = true
  storage_encrypted      = true
}

data "aws_secretsmanager_secret_version" "rds_secret" {
  secret_id = "arn:aws:secretsmanager:us-east-2:209479302876:secret:rdsuserpass-UQPZkQ"
}

locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.rds_secret.secret_string)
}

# Security Group
resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  vpc_id = aws_vpc.RDS_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Allow internal access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}
