resource "aws_ecs_task_definition" "task_python" {
  family                   = "${var.stack_id}-${var.task_definition_python}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  task_role_arn            = aws_iam_role.task_role_arn.arn
  execution_role_arn       = aws_iam_role.ecs_tasks_execution_role.arn

  container_definitions = <<DEFINITION
[
  {
    "cpu": ${var.fargate_cpu},
    "image": "${aws_ecr_repository.image_python.repository_url}",
    "memory": ${var.fargate_memory},
    "name": "${var.stack_id}-${var.task_definition_python}",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${var.app_port},
        "hostPort": ${var.app_port}
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${var.layer}-${var.stack_id}-${var.task_definition_python}-log",
        "awslogs-region": "${var.region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
DEFINITION
}

resource "aws_ecs_service" "python" {
  name            = "${var.layer}-${var.stack_id}-${var.service_fargate_python}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.task_python.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.ecs_tasks.id]
    subnets         = [aws_subnet.private1.id,aws_subnet.private2.id,aws_subnet.private3.id]
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.target_group_python.id
    container_name   = "${var.stack_id}-${var.task_definition_python}"
    container_port   = var.app_port
  }

  depends_on = [
    aws_alb_listener.listener_http
  ]

  lifecycle {
    ignore_changes = [desired_count]
  }
}