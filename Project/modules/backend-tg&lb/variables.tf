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

variable "vpc_id" {
  type        = string
  description = "VPC ID for the target group"
  default     = "module.vpc.vpc_id"
}
variable "backend_sg" {
  type        = string
  description = "Security group for the backend ALB"
  default     = "module.security_group.alb_backend_sg"
  
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for the backend ALB"
  default     = ["module.vpc.public_subnet_1_id", "module.vpc.public_subnet_2_id"]
  
}