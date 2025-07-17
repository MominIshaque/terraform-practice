output "rds_endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "rds_username" {
  value = jsondecode(data.aws_secretsmanager_secret_version.rds_secret_version.secret_string)["username"]
  sensitive = true
}

output "rds_password" {
  value = jsondecode(data.aws_secretsmanager_secret_version.rds_secret_version.secret_string)["password"]
  sensitive = true
}

resource "local_file" "rds_endpoint" {
  filename = "rds_info.txt"
  content  = <<EOT
RDS Endpoint: ${aws_db_instance.rds.endpoint}
RDS Username: ${jsondecode(data.aws_secretsmanager_secret_version.rds_secret_version.secret_string)["username"]}
RDS Password: ${jsondecode(data.aws_secretsmanager_secret_version.rds_secret_version.secret_string)["password"]}
EOT
}