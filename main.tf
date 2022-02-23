provider "aws" {
  region  = var.region   # instant region
  profile = var.aws_user # default user
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  # Keep tfstate in S3 bucket
  # Dont forget to change bucket name and region, if you choose another configuration
  # backend "s3" {
  #   bucket = "dev-demo-s3-password-generator-student-bucket"
  #   key    = "terraform.tfstate"
  #   region = "us-east-2"
  # }
}


# Module for CLuster
# - Create ECS
# - Create IAM
module "cluster" {
  source = "./modules/cluster"

  # Default variables for Cluster module
  env       = var.env
  app_name  = var.app_name
  app_port  = var.app_port
  image_tag = var.image_tag

  default_cidr   = var.default_cidr
  cidr_vpc       = var.cidr_vpc
  public_subnet  = var.public_subnet
  private_subnet = var.private_subnet

  sg_port_cidr_bastion = var.sg_port_cidr_bastion

  # Data from another modules
  registry_url = module.ecr.registry_url # URL of repository
}


# Module for ECR
# - Create ECR repository;
# - Make init build; (future)
# - Make CI/CD. (future)
module "ecr" {
  source = "./modules/ecr"

  # Default variables for ECR module
  region    = var.region
  app_name  = var.app_name
  image_tag = var.image_tag
}


# Module for Initial build
# Build docker image
# Login to AWS
# Push to ECR
module "init-build" {
  source = "./modules/init-build"

  # Default variables for Initial build module
  region      = var.region
  app_name    = var.app_name
  app_port    = var.app_port
  image_tag   = var.image_tag
  working_dir = var.working_dir

  # Variables from another modules
  registry_id = module.ecr.registry_id
}


# Module for S3 Bucket
# Create S3 bucket
# Enable versioning
# Choose private type of S3
module "s3" {
  source = "./modules/s3"

  # Default variables for Initial build module
  env      = var.env
  app_name = var.app_name
  aws_user = var.aws_user
}
