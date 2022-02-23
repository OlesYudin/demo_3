# Create ECS Cluster
resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.app_name}-${var.env}-cluster"
  tags = {
    Name        = "ECS-${var.app_name}"
    Environment = var.env
  }
}

# Add task definition to ECS Cluster
resource "aws_ecs_task_definition" "task-definition" {
  family                   = "${var.app_name}-${var.env}-task-definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.ecs-iam-role.arn
  execution_role_arn       = aws_iam_role.ecs-iam-role.arn
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([
    {
      name = "Container-${var.app_name}-${var.env}",
      # "${var.registry_url}:${var.image_tag}"
      # "564667093156.dkr.ecr.us-east-2.amazonaws.com/test:${var.image_tag}"
      image     = "${var.registry_url}:${var.image_tag}",
      cpu       = 256,
      memory    = 512,
      essential = true # If essential true, when container crash - all task crash

      # If we dont use portmapping, we cant attach task def to cluster. Because AWS dont know in which port container work
      portMappings = [
        {
          "containerPort" : "${var.app_port}"
          "hostPort" : "${var.app_port}"
        }
      ]
    }
  ])

  # Required if use Fargate
  runtime_platform {
    operating_system_family = "LINUX" # The valid values for Amazon ECS tasks hosted on Fargate are LINUX, WINDOWS_SERVER_2019_FULL, and WINDOWS_SERVER_2019_CORE.
    cpu_architecture        = "X86_64"
  }
}

# Execute task definition on created cluster
resource "aws_ecs_service" "password-generator" {
  name            = "${var.app_name}-${var.env}"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.task-definition.arn

  launch_type   = "FARGATE"
  desired_count = 2

  network_configuration {
    subnets          = aws_subnet.private_subnet.*.id
    security_groups  = [aws_security_group.sg_ecs_alb.id]
    assign_public_ip = false # Default false. I dont need atach public IP, because I have ALB
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alb_target.id # ARN of Target group to attach it to ECS
    container_name   = "Container-${var.app_name}-${var.env}"
    container_port   = var.app_port
  }

  depends_on = [aws_lb_listener.alb_listener_http, aws_iam_role_policy.ec2_ecr_read_access]
}

