resource "aws_alb_target_group" "target_group_python" {
  name        = "${var.stack_id}-analitycs"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path = "/"
    port = "traffic-port"
    healthy_threshold = 2
    unhealthy_threshold = 10
    timeout = 30
    interval = 300
    matcher = "200"  # has to be HTTP 200 or fails
  }

  tags = {
    Name        = "${var.layer}-${var.stack_id}-${var.service_fargate_python}"
    Environment = var.stack_id
  }
}