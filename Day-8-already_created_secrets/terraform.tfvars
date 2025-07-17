region       = "us-east-2"
vpc_cidr     = "10.0.0.0/16"
subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]

# DB Credentials (used for RDS and stored in Secrets Manager)
db_username = "admin"

# RDS Configuration
db_instance_identifier = "momin-custom-db-instance"
db_engine              = "mysql"
db_engine_version      = "8.0"
db_instance_class      = "db.t3.micro"
db_name                = "mydatabase"