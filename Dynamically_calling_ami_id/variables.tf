variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
}

variable "ami_name_filter" {
  description = "The AMI name pattern to look for"
  type        = string
}
