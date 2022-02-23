# IAM Role
# TODO:Rewtire using own policy
resource "aws_iam_role" "ecs-iam-role" {
  name               = "${var.app_name}-ecs-iam-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_role_policy.json
  tags = {
    Name = "${var.app_name}-ecs-iam-role"
  }
}

data "aws_iam_policy_document" "ecs_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


resource "aws_iam_role_policy" "ec2_ecr_read_access" {
  name = "ECS-ECR-Read-Access"
  role = aws_iam_role.ecs-iam-role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}
