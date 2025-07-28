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

# variable "rds_subnet_ids" {
#   description = "List of subnet IDs for the RDS instance"
#   type        = list(string)
#   default     = module.vpc.rds_subnet_ids

# }
variable "rds_sg" {
  description = "Security group for RDS instance"
  type        = string
  default     = "module.security_group.rds-sg.id"

}
variable "rds_subnet_ids" {
  description = "Subnet IDs for RDS"
  type        = list(string)
}