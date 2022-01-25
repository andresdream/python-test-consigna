resource "aws_cloudwatch_log_group" "cloudwatch-python" {
  name = "${var.layer}-${var.stack_id}-${var.task_definition_python}-log"

  tags = {
    Environment = "${var.stack_id}"
  }
}