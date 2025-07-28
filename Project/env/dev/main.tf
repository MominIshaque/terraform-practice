
# VPC
module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  az1      = var.az1
  az2      = var.az2

  pub1_cidr  = var.pub1_cidr
  pub2_cidr  = var.pub2_cidr
  prvt3_cidr = var.prvt3_cidr
  prvt4_cidr = var.prvt4_cidr
  prvt5_cidr = var.prvt5_cidr
  prvt6_cidr = var.prvt6_cidr
  prvt7_cidr = var.prvt7_cidr
  prvt8_cidr = var.prvt8_cidr

  pub1_name  = var.pub1_name
  pub2_name  = var.pub2_name
  prvt3_name = var.prvt3_name
  prvt4_name = var.prvt4_name
  prvt5_name = var.prvt5_name
  prvt6_name = var.prvt6_name
  prvt7_name = var.prvt7_name
  prvt8_name = var.prvt8_name

  igw_name        = var.igw_name
  public_rt_name  = var.public_rt_name
  private_rt_name = var.private_rt_name
  nat_name        = var.nat_name
  anywhere        = var.anywhere
}

# Security Groups
module "security_groups" {
  source    = "../../modules/security_group"
  allow_all = var.allow_all

  ssh_port   = var.ssh_port
  http_port  = var.http_port
  https_port = var.https_port
  mysql_port = var.mysql_port

  ssh_desc   = var.ssh_desc
  http_desc  = var.http_desc
  https_desc = var.https_desc
  mysql_desc = var.mysql_desc

  bastion_sg_name = var.bastion_sg_name
  bastion_sg_desc = var.bastion_sg_desc
  bastion_sg_tag  = var.bastion_sg_tag

  alb_frontend_name = var.alb_frontend_name
  alb_frontend_desc = var.alb_frontend_desc
  alb_frontend_tag  = var.alb_frontend_tag

  alb_backend_name = var.alb_backend_name
  alb_backend_desc = var.alb_backend_desc
  alb_backend_tag  = var.alb_backend_tag

  frontend_sg_name = var.frontend_sg_name
  frontend_sg_desc = var.frontend_sg_desc
  frontend_sg_tag  = var.frontend_sg_tag

  backend_sg_name = var.backend_sg_name
  backend_sg_desc = var.backend_sg_desc
  backend_sg_tag  = var.backend_sg_tag

  rds_sg_name = var.rds_sg_name
  rds_sg_desc = var.rds_sg_desc
  rds_sg_tag  = var.rds_sg_tag
}

# Bastion Host
module "bastion" {
  source                = "../../modules/bastionserver"
  ami                   = var.ami
  instance_type         = var.instance_type
  key_name              = var.key_name
  bastion_instance_name = var.bastion_instance_name
}

# RDS
module "rds" {
  source                  = "../../modules/rds"
  rds_allocated_storage   = var.rds_allocated_storage
  rds_identifier          = var.rds_identifier
  rds_engine              = var.rds_engine
  rds_engine_version      = var.rds_engine_version
  rds_instance_class      = var.rds_instance_class
  rds_multi_az            = var.rds_multi_az
  rds_db_name             = var.rds_db_name
  rds_username            = var.rds_username
  rds_password            = var.rds_password
  rds_skip_final_snapshot = var.rds_skip_final_snapshot
  rds_publicly_accessible = var.rds_publicly_accessible
  rds_backup_retention    = var.rds_backup_retention
  db_subnet_group_name    = var.db_subnet_group_name
  db_subnet_group_tag     = var.db_subnet_group_tag
  rds_subnet_ids          = var.rds_subnet_ids

}

# Launch Template - Frontend
module "launch_template_frontend" {
  source                 = "../../modules/launchtemp"
  ami_owner              = var.ami_owner
  frontend_ami_name      = var.frontend_ami_name
  key_name               = var.key_name
  frontend_lt_name       = "project-frontend_lt"
  frontend_lt_desc       = var.frontend_lt_desc
  frontend_instance_type = var.frontend_instance_type
  frontend_lt_tag        = var.frontend_lt_tag
}

# Launch Template - Backend
module "launch_template_backend" {
  source                = "../../modules/launchtemp"
  ami_owner             = var.ami_owner
  backend_ami_name      = var.backend_ami_name
  key_name              = var.key_name
  backend_lt_name       = "project-backend_lt"
  backend_lt_desc       = var.backend_lt_desc
  backend_instance_type = var.backend_instance_type
  backend_lt_tag        = var.backend_lt_tag
}

# ALB - Frontend
module "alb_frontend" {
  source                        = "../../modules/frontend-tg&lb"
  frontend_alb_name             = var.frontend_alb_name
  frontend_alb_internal         = var.frontend_alb_internal
  frontend_alb_type             = var.frontend_alb_type
  frontend_alb_tag              = var.frontend_alb_tag
  frontend_listener_port        = var.frontend_listener_port
  frontend_listener_protocol    = var.frontend_listener_protocol
  frontend_listener_action_type = var.frontend_listener_action_type
  frontend_tg_name              = var.frontend_tg_name
  frontend_tg_port              = var.frontend_tg_port
  frontend_tg_protocol          = var.frontend_tg_protocol
  vpc_id = module.vpc.vpc_id
}

# ALB - Backend
module "alb_backend" {
  source                       = "../../modules/backend-tg&lb"
  backend_alb_name             = var.backend_alb_name
  backend_alb_internal         = var.backend_alb_internal
  backend_alb_type             = var.backend_alb_type
  backend_alb_tag              = var.backend_alb_tag
  backend_listener_port        = var.backend_listener_port
  backend_listener_protocol    = var.backend_listener_protocol
  backend_listener_action_type = var.backend_listener_action_type
  backend_tg_name              = var.backend_tg_name
  backend_tg_port              = var.backend_tg_port
  backend_tg_protocol          = var.backend_tg_protocol
  vpc_id = module.vpc.vpc_id
}

# ASG - Frontend
module "autoscalling" {
  source                    = "../../modules/autoscalling"
  frontend_asg_name_prefix  = var.frontend_asg_name_prefix
  frontend_desired_capacity = var.frontend_desired_capacity
  frontend_max_size         = var.frontend_max_size
  frontend_min_size         = var.frontend_min_size
  #frontend_subnet_ids       = module.vpc.private_subnet_ids_frontend
  health_check_type         = var.health_check_type
  min_healthy_percentage    = var.min_healthy_percentage
  frontend_refresh_trigger  = var.frontend_refresh_trigger
  frontend_asg_name         = var.frontend_asg_name
  #launch_template_module  = module.launch_template_frontend
# }

# ASG - Backend
#
  # source                   = "../../modules/autoscalling"
  backend_asg_name_prefix  = var.backend_asg_name_prefix
  backend_desired_capacity = var.backend_desired_capacity
  backend_max_size         = var.backend_max_size
  backend_min_size         = var.backend_min_size
  # backend_subnet_ids       = module.vpc.private_subnet_ids_backend
  # health_check_type        = var.health_check_type
  # min_healthy_percentage   = var.min_healthy_percentage
  backend_refresh_trigger  = var.backend_refresh_trigger
  backend_asg_name         = var.backend_asg_name
  #launch_template_module  = module.launch_template_backend
}
