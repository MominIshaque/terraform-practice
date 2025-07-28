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

variable "vpc_id" {
  type        = string
  description = "VPC ID for the target group"
  default     = "module.vpc.vpc_id"
  
}
variable "frontend_sg" {
  type        = string
  description = "Security group for the frontend ALB"
  default     = "module.security_group.alb_frontend_sg"
}
variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for the frontend ALB"
  default     = ["module.vpc.public_subnet_ids"]

}