# Common
variable "allow_all" { default = "" }

# Port Descriptions
variable "ssh_port" { default = ""}
variable "http_port" { default = "" }
variable "https_port" { default = "" }
variable "mysql_port" { default = "" }

variable "ssh_desc" { default = "" }
variable "http_desc" { default = "" }
variable "https_desc" { default = "" }
variable "mysql_desc" { default = "" }

# Bastion
variable "bastion_sg_name" { default = "" }
variable "bastion_sg_desc" { default = "" }
variable "bastion_sg_tag"  { default = "" }

# ALB - Frontend
variable "alb_frontend_name" { default = "" }
variable "alb_frontend_desc" { default = "" }
variable "alb_frontend_tag"  { default = "" }

# ALB - Backend
variable "alb_backend_name" { default = "" }
variable "alb_backend_desc" { default = "" }
variable "alb_backend_tag"  { default = "" }

# Frontend Server
variable "frontend_sg_name" { default = "" }
variable "frontend_sg_desc" { default = "" }
variable "frontend_sg_tag"  { default = "" }

# Backend Server
variable "backend_sg_name" { default = "" }
variable "backend_sg_desc" { default = "" }
variable "backend_sg_tag"  { default = "" }

# RDS
variable "rds_sg_name" { default = "" }
variable "rds_sg_desc" { default = "" }
variable "rds_sg_tag"  { default = "" }

variable "vpc_id" {
  description = "VPC ID where the security groups will be created"
  type        = string
  default     = "module.vpc.vpc_id"

}
