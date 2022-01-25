
### ECS
resource "aws_ecs_cluster" "main" {
  name = "${var.layer}-${var.stack_id}-${var.cluster_java_name}"
}