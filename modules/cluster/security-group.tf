# Security group for ALB
resource "aws_security_group" "sg_ecs_alb" {
  name        = "SG-HTTP"
  description = "Security group for ALB and ECS"
  vpc_id      = aws_vpc.vpc.id

  # Inbound rules for app port
  ingress {
    description = "HTTP for ALB and ECS"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = [var.default_cidr]
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_cidr]
  }

  tags = {
    Name        = "SG-HTTP-ALB-ECS-${var.env}"
    Environment = var.env
  }
}

# Security group for Bation Host
resource "aws_security_group" "sg_bastion" {
  name        = "SG-SSH-HTTP"
  description = "Security group for SSH, HTTP connection to EC2 instance (bastion)"
  vpc_id      = aws_vpc.vpc.id

  # Inbound rules for 22 ports
  # Open 22 to my IP and my VPC
  # Open 80 for all
  dynamic "ingress" {
    for_each = var.sg_port_cidr_bastion
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = ingress.value
    }
  }
  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_cidr]
  }

  tags = {
    Name        = "SG-SSH-HTTP-${var.env}"
    Environment = var.env
  }
}
