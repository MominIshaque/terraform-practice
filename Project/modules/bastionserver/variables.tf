variable "ami" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Key pair name to access the instance"
  type        = string
}

variable "bastion_instance_name" {
  description = "Name tag for the bastion EC2 instance"
  type        = string
  default     = ""
}

variable "public_subnet_1_id" {
  description = "ID of the first public subnet"
  type        = string
  default     = "module.vpc.public_subnet_1_id"

}

variable "bastion_sg_id" {
  description = "ID of the security group for the bastion host"
  type        = string
  default     = "module.security_group.bastion_sg"
  
}
