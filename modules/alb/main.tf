resource "aws_lb" "application_load_balancer" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = [var.pb_sub1_id,var.pb_sub2_id]

  enable_deletion_protection = false

  tags = {
    name = "${var.project_name}-alb"
  }
}

resource "aws_alb_target_group" "tg1" {
  name     = "${var.project_name}-tg"
  port     = 80
  target_type = "instance"
  protocol = "HTTP"
  vpc_id   = var.vpc_id

    health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = 200
    healthy_threshold   = 2
    unhealthy_threshold = 5
  }

   lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg1.arn
}

}