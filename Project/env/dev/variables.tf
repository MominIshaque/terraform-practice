##vpc

variable "vpc_cidr" {
  default = ""
}
variable "vpc_name" {
  default = ""
}

variable "az1" {
  default = ""
}
variable "az2" {
  default = ""
}

variable "pub1_cidr" { default = "" }
variable "pub2_cidr" { default = "" }

variable "prvt3_cidr" { default = "" }
variable "prvt4_cidr" { default = "" }
variable "prvt5_cidr" { default = "" }
variable "prvt6_cidr" { default = "" }
variable "prvt7_cidr" { default = "" }
variable "prvt8_cidr" { default = "" }

variable "pub1_name" { default = "" }
variable "pub2_name" { default = "" }

variable "prvt3_name" { default = "" }
variable "prvt4_name" { default = "" }
variable "prvt5_name" { default = "" }
variable "prvt6_name" { default = "" }
variable "prvt7_name" { default = "" }
variable "prvt8_name" { default = "" }

variable "igw_name" {
  default = ""
}

variable "public_rt_name" {
  default = ""
}

variable "private_rt_name" {
  default = ""
}

variable "nat_name" {
  default = ""
}

variable "anywhere" {
  default = ""
}

## security group

# Common
variable "allow_all" { default = "" }

# Port Descriptions
variable "ssh_port" { default = "" }
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
variable "bastion_sg_tag" { default = "" }

# ALB - Frontend
variable "alb_frontend_name" { default = "" }
variable "alb_frontend_desc" { default = "" }
variable "alb_frontend_tag" { default = "" }

# ALB - Backend
variable "alb_backend_name" { default = "" }
variable "alb_backend_desc" { default = "" }
variable "alb_backend_tag" { default = "" }

# Frontend Server
variable "frontend_sg_name" { default = "" }
variable "frontend_sg_desc" { default = "" }
variable "frontend_sg_tag" { default = "" }

# Backend Server
variable "backend_sg_name" { default = "" }
variable "backend_sg_desc" { default = "" }
variable "backend_sg_tag" { default = "" }

# RDS
variable "rds_sg_name" { default = "" }
variable "rds_sg_desc" { default = "" }
variable "rds_sg_tag" { default = "" }


## rds variables

# RDS instance variables
variable "rds_allocated_storage" {
  default = ""
}

variable "rds_identifier" {
  default = ""
}

variable "rds_engine" {
  default = ""
}

variable "rds_engine_version" {
  default = ""
}

variable "rds_instance_class" {
  default = ""
}

variable "rds_multi_az" {
  default = ""
}

variable "rds_db_name" {
  default = ""
}

variable "rds_username" {
  description = "RDS Master Username"
  type        = string
}

variable "rds_password" {
  description = "RDS Master Password"
  type        = string
  sensitive   = true
}

variable "rds_skip_final_snapshot" {
  default = ""
}

variable "rds_publicly_accessible" {
  default = ""
}

variable "rds_backup_retention" {
  default = ""
}

# DB Subnet Group
variable "db_subnet_group_name" {
  default = ""
}

variable "db_subnet_group_tag" {
  default = ""
}


## launch temp variables

# Common
variable "key_name" {
  description = "SSH Key pair name for EC2 instances"
  default     = ""
}

variable "ami_owner" {
  description = "AMI owner ID or 'self' if using own AMI"
  default     = ""
}

# Frontend
variable "frontend_ami_name" {
  description = "AMI name pattern for frontend"
  default     = ""
}

variable "frontend_lt_name" {
  default = ""
}

variable "frontend_lt_desc" {
  default = ""
}

variable "frontend_instance_type" {
  default = ""
}

variable "frontend_lt_tag" {
  default = ""
}

# Backend
variable "backend_ami_name" {
  description = "AMI name pattern for backend"
  default     = ""
}

variable "backend_lt_name" {
  default = ""
}

variable "backend_lt_desc" {
  default = ""
}

variable "backend_instance_type" {
  default = ""
}

variable "backend_lt_tag" {
  default = ""
}

## frontend tg lb

# Target Group
variable "frontend_tg_name" {
  default     = ""
  description = "Name of the target group for frontend"
}

variable "frontend_tg_port" {
  default     = ""
  description = "Port for the frontend target group"
}

variable "frontend_tg_protocol" {
  default     = ""
  description = "Protocol for the frontend target group"
}

# ALB
variable "frontend_alb_name" {
  default     = ""
  description = "Name of the ALB for frontend"
}

variable "frontend_alb_internal" {
  default     = ""
  description = "Whether the ALB is internal"
}

variable "frontend_alb_type" {
  default     = ""
  description = "Load balancer type"
}

variable "frontend_alb_tag" {
  default     = ""
  description = "Tag for the ALB"
}

# Listener
variable "frontend_listener_port" {
  default     = ""
  description = "Listener port for ALB"
}

variable "frontend_listener_protocol" {
  default     = ""
  description = "Listener protocol for ALB"
}

variable "frontend_listener_action_type" {
  default     = ""
  description = "Default action type for ALB listener"
}


## backend tg lb


# Target Group
variable "backend_tg_name" {
  default     = ""
  description = "Name of the target group for backend"
}

variable "backend_tg_port" {
  default     = ""
  description = "Port for the backend target group"
}

variable "backend_tg_protocol" {
  default     = ""
  description = "Protocol for the backend target group"
}

# ALB
variable "backend_alb_name" {
  default     = ""
  description = "Name of the ALB for backend"
}

variable "backend_alb_internal" {
  default     = ""
  description = "Whether the backend ALB is internal"
}

variable "backend_alb_type" {
  default     = ""
  description = "Type of backend load balancer"
}

variable "backend_alb_tag" {
  default     = ""
  description = "Tag for the backend ALB"
}

# Listener
variable "backend_listener_port" {
  default     = ""
  description = "Port on which backend ALB listens"
}

variable "backend_listener_protocol" {
  default     = ""
  description = "Protocol for backend listener"
}

variable "backend_listener_action_type" {
  default     = ""
  description = "Action type for backend listener"

}


## bastion host variables

variable "ami" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = ""
}

# variable "key_name" {
#   description = "Key pair name to access the instance"
#   type        = string
# }

variable "bastion_instance_name" {
  description = "Name tag for the bastion EC2 instance"
  type        = string
  default     = ""
}


## auto scaling variables

variable "frontend_asg_name_prefix" {
  description = "Prefix for the frontend ASG"
  type        = string
  default     = ""
}

variable "backend_asg_name_prefix" {
  description = "Prefix for the backend ASG"
  type        = string
  default     = ""
}

variable "frontend_desired_capacity" {
  description = "Desired capacity for frontend ASG"
  type        = number
}

variable "backend_desired_capacity" {
  description = "Desired capacity for backend ASG"
  type        = number
}

variable "frontend_max_size" {
  description = "Max size for frontend ASG"
  type        = number
}

variable "backend_max_size" {
  description = "Max size for backend ASG"
  type        = number
}

variable "frontend_min_size" {
  description = "Min size for frontend ASG"
  type        = number
}

variable "backend_min_size" {
  description = "Min size for backend ASG"
  type        = number
}

# variable "frontend_subnet_ids" {
#   description = "Private subnet IDs for frontend ASG"
#   type        = list(string)
#   default     = module.vpc.private_subnet_ids_frontend
# }

# variable "backend_subnet_ids" {
#   description = "Private subnet IDs for backend ASG"
#   type        = list(string)
#   # default     = [aws_subnet.prvt5.id, aws_subnet.prvt6.id]
# }

variable "health_check_type" {
  description = "Health check type for ASG"
  type        = string
}

variable "min_healthy_percentage" {
  description = "Minimum healthy percentage for instance refresh"
  type        = number

}

variable "frontend_refresh_trigger" {
  description = "Trigger for frontend ASG instance refresh"
  type        = string

}

variable "backend_refresh_trigger" {
  description = "Trigger for backend ASG instance refresh"
  type        = string

}

variable "frontend_asg_name" {
  description = "Tag name for frontend ASG"
  type        = string

}

variable "backend_asg_name" {
  description = "Tag name for backend ASG"
  type        = string

}

variable "rds_subnet_ids" {
  description = "Subnet IDs for RDS instances"
  type        = list(string)
  default     = [] # This should be set to the actual subnet IDs where RDS will be deployed

}