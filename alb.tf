
### ALB
resource "aws_alb" "internal_alb" {
  name            = "${var.stack_id}-lb-ft-internal"
  subnets         = [aws_subnet.private1.id,aws_subnet.private2.id,aws_subnet.private3.id]
  internal           = true
  enable_cross_zone_load_balancing = true
  security_groups = [aws_security_group.lb.id]
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_alb.internal_alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type            = "fixed-response"

    fixed_response {
      status_code   = "404"
      content_type  = "text/plain"
      message_body  = "Pagina no encontrada"
    }
  }
}