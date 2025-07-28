resource "aws_autoscaling_group" "frontend-asg" {
  name_prefix         = var.frontend_asg_name_prefix
  desired_capacity    = var.frontend_desired_capacity
  max_size            = var.frontend_max_size
  min_size            = var.frontend_min_size
  vpc_zone_identifier = var.frontend_subnet_ids
  target_group_arns   = [var.frontend_target_group_arn]
  health_check_type   = var.health_check_type

  launch_template {
    name     = "project-frontend_lt"
    version  = "$Default"
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = var.min_healthy_percentage
    }
    triggers = [var.frontend_refresh_trigger]
  }

  tag {
    key                 = "Name"
    value               = var.frontend_asg_name
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "backend-asg" {
  # backend_asg_name      = var.backend_asg_name
  name_prefix           = var.backend_asg_name_prefix
  desired_capacity      = var.backend_desired_capacity
  max_size              = var.backend_max_size
  min_size              = var.backend_min_size
  vpc_zone_identifier   = var.backend_subnet_ids
  target_group_arns     = [var.backend_target_group_arn]
  health_check_type     = var.health_check_type

  launch_template {
    name      = "project-backend_lt"
    version   = "$Default"
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = var.min_healthy_percentage
    }
    triggers = [var.backend_refresh_trigger]
  }

  tag {
    key                 = "Name"
    value               = var.backend_asg_name
    propagate_at_launch = true
  }
}
