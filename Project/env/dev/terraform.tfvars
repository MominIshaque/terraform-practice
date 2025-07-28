# terraform.tfvars

## VPC setup

vpc_cidr = "172.20.0.0/16"
vpc_name = "3-tier-vpc"

az1 = "us-east-1a"
az2 = "us-east-1b"

pub1_cidr = "172.20.1.0/24"
pub2_cidr = "172.20.2.0/24"

prvt3_cidr = "172.20.3.0/24"
prvt4_cidr = "172.20.4.0/24"
prvt5_cidr = "172.20.5.0/24"
prvt6_cidr = "172.20.6.0/24"
prvt7_cidr = "172.20.7.0/24"
prvt8_cidr = "172.20.8.0/24"

pub1_name = "pub-1a"
pub2_name = "pub-2b"

prvt3_name = "prvt-3a"
prvt4_name = "prvt-4b"
prvt5_name = "prvt-5a"
prvt6_name = "prvt-6b"
prvt7_name = "prvt-7a"
prvt8_name = "prvt-8b"

igw_name        = "3-tier-ig"
public_rt_name  = "3-tier-pub-rt"
private_rt_name = "3-tier-prvt-rt"
nat_name        = "3-tier-nat"

anywhere = "0.0.0.0/0"

## Security Groups setup

# Common
allow_all = "0.0.0.0/0"

# Port Descriptions
ssh_port   = 22
http_port  = 80
https_port = 443
mysql_port = 3306

ssh_desc   = "ssh"
http_desc  = "http"
https_desc = "https"
mysql_desc = "mysql/aurora"

# Bastion
bastion_sg_name = "appserver-SG"
bastion_sg_desc = "Allow inbound traffic from ALB"
bastion_sg_tag  = "bastion-host-server-sg"

# ALB - Frontend
alb_frontend_name = "alb-frontend-sg"
alb_frontend_desc = "Allow inbound traffic from ALB"
alb_frontend_tag  = "alb-frontend-sg"

# ALB - Backend
alb_backend_name = "alb-backend-sg"
alb_backend_desc = "Allow inbound traffic ALB"
alb_backend_tag  = "alb-backend-sg"

# Frontend Server
frontend_sg_name = "frontend-server-sg"
frontend_sg_desc = "Allow inbound traffic"
frontend_sg_tag  = "frontend-server-sg"

# Backend Server
backend_sg_name = "backend-server-sg"
backend_sg_desc = "Allow inbound traffic"
backend_sg_tag  = "backend-server-sg"

# RDS
rds_sg_name = "book-rds-sg"
rds_sg_desc = "Allow inbound"
rds_sg_tag  = "book-rds-sg"

## RDS setup

# RDS instance variables
rds_allocated_storage = 20
rds_identifier        = "book-rds"
rds_engine            = "mysql"
rds_engine_version    = "8.0.32"
rds_instance_class    = "db.t3.micro"
rds_multi_az          = true
rds_db_name           = "mydb"

# Provide these manually and securely
rds_username = "admin"
rds_password = "PassMomin"

rds_skip_final_snapshot = true
rds_publicly_accessible = false
rds_backup_retention    = 7

# DB Subnet Group
db_subnet_group_name = "main"
db_subnet_group_tag  = "My DB subnet group"

## Launch Templates setup

# Common
key_name  = "awskey1"
ami_owner = "self"

# Frontend
frontend_ami_name      = "frontend-ami"
frontend_lt_name       = "project-frontend-lt"
frontend_lt_desc       = "project-frontend-lt"
frontend_instance_type = "t3.medium"
frontend_lt_tag        = "project-frontend-lt"

# Backend
backend_ami_name      = "backend-ami"
backend_lt_name       = "project-backend-lt"
backend_lt_desc       = "project-backend-lt"
backend_instance_type = "t3.medium"
backend_lt_tag        = "project-backend-lt"

## Frontend Target Group and Load Balancer setup

# Target Group
frontend_tg_name     = "frontend-tg"
frontend_tg_port     = 80
frontend_tg_protocol = "HTTP"

# ALB
frontend_alb_name     = "frontend-alb"
frontend_alb_internal = false
frontend_alb_type     = "application"
frontend_alb_tag      = "ALB-Frontend"

# Listener
frontend_listener_port        = 80
frontend_listener_protocol    = "HTTP"
frontend_listener_action_type = "forward"

## Backend Target Group and Load Balancer setup

backend_tg_name     = "backend-tg"
backend_tg_port     = 80
backend_tg_protocol = "HTTP"

# ALB
backend_alb_name     = "backend-alb"
backend_alb_internal = false
backend_alb_type     = "application"
backend_alb_tag      = "ALB-Backend"

# Listener
backend_listener_port        = 80
backend_listener_protocol    = "HTTP"
backend_listener_action_type = "forward"

## Bastion Server setup

ami           = "ami-020cba7c55df1f615" # Replace with your actual AMI ID
instance_type = "t3.medium"
#key_name              = "awskey1"
bastion_instance_name = "bastion-server"


## Autoscaling setup

# Frontend ASG
frontend_asg_name_prefix  = "frontend-asg"
frontend_desired_capacity = 1
frontend_max_size         = 1
frontend_min_size         = 1
# frontend_subnet_ids       = module.vpc.private_subnet_ids_frontend
frontend_refresh_trigger  = "desired_capacity"
frontend_asg_name         = "frontend-asg"

# Backend ASG
backend_asg_name_prefix  = "backend-asg"
backend_desired_capacity = 1
backend_max_size         = 1
backend_min_size         = 1
# backend_subnet_ids       = module.vpc.private_subnet_ids_backend
backend_refresh_trigger  = "desired_capacity"
backend_asg_name         = "backend-asg"

# Common
health_check_type      = "EC2"
min_healthy_percentage = 50

