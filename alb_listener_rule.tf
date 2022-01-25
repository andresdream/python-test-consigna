
resource "aws_alb_listener_rule" "listener_rule_python" {
    listener_arn = aws_alb_listener.listener_http.arn
    action {    
      type             = "forward"    
      target_group_arn = aws_alb_target_group.target_group_python.arn
    }   
    condition {    
      path_pattern {
        values = ["/*"]
      }
    }
}