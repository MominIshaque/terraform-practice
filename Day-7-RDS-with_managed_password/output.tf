output "rds_endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "rds_master_user_password" {
  value     = data.aws_secretsmanager_secret_version.rds_password.secret_string
  sensitive = true
}

resource "local_file" "rds_endpoint" {
  filename = "rds_endpoint.txt"
  content  = <<EOT
RDS Endpoint: ${aws_db_instance.rds.endpoint}
Master User Password: ${data.aws_secretsmanager_secret_version.rds_password.secret_string}
EOT
}