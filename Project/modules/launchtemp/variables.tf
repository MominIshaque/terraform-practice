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

variable "frontend_sg" {
  description = "Security group for the frontend ALB"
  type        = string
  default     = "module.security_group.alb_frontend_sg"

}
variable "backend_sg" {
  description = "Security group for the backend ALB"
  type        = string
  default     = "module.security_group.alb_backend_sg"
}