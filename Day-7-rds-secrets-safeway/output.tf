output "rds_endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}

output "secrets_manager_secret_arn" {
  value = aws_secretsmanager_secret.db_secret.arn
}

output "secrets_manager_secret_version_arn" {
  value = aws_secretsmanager_secret_version.db_secret_version.arn
}

resource "local_file" "rds_endpoint" {
  filename = "info.txt"
  content  = <<EOT
    RDS Endpoint: ${aws_db_instance.rds.endpoint}
    Database Password: ${random_password.db_password.result}
    Secrets Manager Secret ARN: ${aws_secretsmanager_secret.db_secret.arn}
    Secrets Manager Secret Version ARN: ${aws_secretsmanager_secret_version.db_secret_version.arn}
EOT
}