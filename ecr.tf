resource "aws_ecr_repository" "image_python" {
  name                 = "${var.layer}-${var.stack_id}-python"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}