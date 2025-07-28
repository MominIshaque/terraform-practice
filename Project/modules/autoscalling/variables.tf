variable "frontend_asg_name_prefix" {
  description = "Prefix for the frontend ASG"
  type        = string
 
}

variable "backend_asg_name_prefix" {
  description = "Prefix for the backend ASG"
  type        = string

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

variable "frontend_subnet_ids" {
  description = "Private subnet IDs for frontend ASG"
  type        = list(string)
  default     = [ "module.vpc.private_subnet_ids_frontend" ]
}

variable "backend_subnet_ids" {
  description = "Private subnet IDs for backend ASG"
  type        = list(string)
  default     = [ "module.vpc.private_subnet_ids_backend" ]
 
}

variable "frontend_target_group_arn" {
  type        = string
  description = "ARN of the frontend target group"
  default     = "module.frontend-tg&lb.frontend_tg_arn"
}

variable "backend_target_group_arn" {
  type        = string
  description = "ARN of the backend target group"
  default     = "module.backend-tg&lb.backend_tg_arn"
}

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

variable "frontend_lt_id" {
  type        = string
  description = "Frontend launch template ID"
  default     = "module.launchtemp.frontend_lt_id"
}

variable "frontend_lt_version" {
  type        = string
  description = "Frontend launch template version"
  default     = "module.launchtemp.frontend_lt_version"
}

variable "backend_lt_id" {
  type        = string
  description = "Backend launch template ID"
  default     = "module.launchtemp.backend_lt_id"
}

variable "backend_lt_version" {
  type        = string
  description = "Backend launch template version"
  default     = "module.launchtemp.backend_lt_version"
}

variable "frontend_launch_template_name" {
  description = "Name of the frontend launch template"
  type        = string
  default     = "module.launchtemp.frontend_launch_template_name"

}

variable "backend_launch_template_name" {
  description = "Name of the backend launch template"
  type        = string
  default     = "module.launchtemp.backend_launch_template_name"
  
}