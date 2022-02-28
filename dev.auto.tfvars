# Default region where will be created infrastructure
region = "us-east-2"
# Default user that will push infrastructure to AWS
aws_user = "student" 
# Environment
env = "dev"


# -----------
# VPC
# -----------
# Default VPC CIDR
cidr_vpc = "172.31.0.0/16" 

# Default public subnets for VPC
public_subnet = ["172.31.1.0/24", "172.31.2.0/24"]
# Default private subnets for VPC
private_subnet = ["172.31.11.0/24", "172.31.12.0/24"]
# Default CIDR for routing traffic
default_cidr = "0.0.0.0/0"

# -----------
# SG
# -----------
# Port for Application (ALB)
app_port = 80
# Open ports to CIDR (for bastion)
sg_port_cidr_bastion = { 
    "22" = ["195.88.72.206/32", "172.31.0.0/16"],
    "80" = ["0.0.0.0/0"]
}


# ----------
# EC2
# ----------
# Default instance type
instance_type  = "t2.micro"


# ----------
# ECR
# ----------
# Name of container for App
app_name  = "password-generator"
# Container image tag
image_tag = "latest"


# ----------
# Codebuild
# ----------
# Work in /home/student
working_dir = "/home/student/demo_3/App"