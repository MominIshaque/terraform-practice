variable "region" {
  default = ""
}

variable "vpc_cidr" {
  default = ""
}

variable "db_subnet_cidrs" {
  default = [""]
}

variable "db_username" {
  default = ""
}

variable "db_instance_class" {
  default = ""
}

variable "db_engine" {
  default = ""
}

variable "db_engine_version" {
  default = ""
}

variable "db_name" {
  default = ""
}

variable "db_port" {
  default = 3306
}
