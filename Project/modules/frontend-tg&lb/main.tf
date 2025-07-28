resource "aws_lb_target_group" "front_end" {
  name     = var.frontend_tg_name
  port     = var.frontend_tg_port
  protocol = var.frontend_tg_protocol
  vpc_id   = var.vpc_id

  depends_on = [var.vpc_id]
}

resource "aws_lb" "front_end" {
  name               = var.frontend_alb_name
  internal           = var.frontend_alb_internal
  load_balancer_type = var.frontend_alb_type
  security_groups    = [var.frontend_sg]
  subnets            = var.public_subnet_ids

  tags = {
    Name = var.frontend_alb_tag
  }

  depends_on = [aws_lb_target_group.front_end]
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = var.frontend_listener_port
  protocol          = var.frontend_listener_protocol

  default_action {
    type             = var.frontend_listener_action_type
    target_group_arn = aws_lb_target_group.front_end.arn
  }

  depends_on = [aws_lb_target_group.front_end]
}
