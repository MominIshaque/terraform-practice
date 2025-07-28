resource "aws_db_instance" "rds" {
  allocated_storage         = var.rds_allocated_storage
  identifier                = var.rds_identifier
  db_subnet_group_name      = aws_db_subnet_group.sub_grp.id
  engine                    = var.rds_engine
  engine_version            = var.rds_engine_version
  instance_class            = var.rds_instance_class
  multi_az                  = var.rds_multi_az
  db_name                   = var.rds_db_name
  username                  = var.rds_username
  password                  = var.rds_password
  skip_final_snapshot       = var.rds_skip_final_snapshot
  vpc_security_group_ids    = [var.rds_sg]
  publicly_accessible       = var.rds_publicly_accessible
  backup_retention_period   = var.rds_backup_retention

  depends_on = [aws_db_subnet_group.sub_grp]

  tags = {
    DB_identifier = var.rds_identifier
  }
}

resource "aws_db_subnet_group" "sub_grp" {
  name       = var.db_subnet_group_name
  subnet_ids = var.rds_subnet_ids

  depends_on = [var.rds_subnet_ids]

  tags = {
    Name = var.db_subnet_group_tag
  }
}
