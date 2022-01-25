
resource "aws_iam_role" "task_role_arn" {
  name = "${var.layer}-${var.stack_id}-taskrole-fargate"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
            "Service": [
                "s3.amazonaws.com",
                "lambda.amazonaws.com",
                "ecs.amazonaws.com",
                "batch.amazonaws.com",
                "ecs-tasks.amazonaws.com"
            ]
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy" "access_policy" {
  name = "${var.layer}-${var.stack_id}-access_policy_fargate"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Sid": "Stmt1532966429082",
        "Action": [
        "s3:PutObject",
        "s3:PutObjectTagging",
        "s3:PutObjectVersionTagging"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::*"
    },
    {
        "Sid": "Stmt1532967608746",
        "Action": "lambda:*",
        "Effect": "Allow",
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": [
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "task-role-attach" {
    role       = aws_iam_role.task_role_arn.name
    policy_arn = aws_iam_policy.access_policy.arn
}

#https://docs.amazonaws.cn/en_us/AmazonECS/latest/developerguide/task_execution_IAM_role.html, if not exists create
data "aws_iam_policy_document" "ecs_tasks_execution_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_tasks_execution_role" {
  name               = "${var.layer}-${var.stack_id}-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_execution_role.json
}

resource "aws_iam_role_policy_attachment" "ecs_tasks_execution_role" {
  role       = aws_iam_role.ecs_tasks_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}