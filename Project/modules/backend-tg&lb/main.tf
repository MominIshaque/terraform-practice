resource "aws_lb_target_group" "back_end" {
  name     = var.backend_tg_name
  port     = var.backend_tg_port
  protocol = var.backend_tg_protocol
  vpc_id   = var.vpc_id

  depends_on = [var.vpc_id]
}

resource "aws_lb" "back_end" {
  name               = var.backend_alb_name
  internal           = var.backend_alb_internal
  load_balancer_type = var.backend_alb_type
  security_groups    = [var.backend_sg]
  subnets            = var.public_subnet_ids

  tags = {
    Name = var.backend_alb_tag
  }

  depends_on = [aws_lb_target_group.back_end]
}

resource "aws_lb_listener" "back_end" {
  load_balancer_arn = aws_lb.back_end.arn
  port              = var.backend_listener_port
  protocol          = var.backend_listener_protocol

  default_action {
    type             = var.backend_listener_action_type
    target_group_arn = aws_lb_target_group.back_end.arn
  }

  depends_on = [aws_lb_target_group.back_end]
}
