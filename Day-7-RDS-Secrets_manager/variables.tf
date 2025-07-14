variable "region" {
  default = ""
}

variable "vpc_cidr" {
  default = ""
}

variable "subnet_cidrs" {
  type    = list(string)
  default = [""]
}

variable "db_username" {}
variable "db_password" {}

variable "db_instance_identifier" {
  default = ""
}

variable "db_engine" {
  default = ""
}

variable "db_engine_version" {
  default = ""
}

variable "db_instance_class" {
  default = ""
}

variable "db_name" {
  default = ""
}