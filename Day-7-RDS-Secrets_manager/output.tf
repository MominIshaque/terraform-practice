output "rds_endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "secret_arn" {
  value = aws_secretsmanager_secret.rds_secret.arn
}

resource "local_file" "rds_endpoint" {
  filename = "rds_endpoint.txt"
  content  = <<EOT
RDS Endpoint: ${aws_db_instance.rds.endpoint}
EOT
}