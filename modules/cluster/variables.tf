# App name for ECS
variable "app_name" {
  description = "Default Application name"
  type        = string
}
# Environment for ECS
variable "env" {
  description = "Environment"
  type        = string
}

# ECS and ECR
# URL of repository that will push to ECS
variable "registry_url" {
  description = "Repository for ecs"
  type        = string
}
# Docker image tag
variable "image_tag" {
  description = "Default tag for repository"
  type        = string
}

# Network
# CIDR for VPC
variable "cidr_vpc" {
  description = "CIDR of VPC"
  type        = string
}
# CIDR for Public Subnet
variable "public_subnet" {
  description = "Public CIDR-block for subnets"
  type        = list(string)
}
# CIDR for Private Subnet
variable "private_subnet" {
  description = "Private CIDR-block for subnets"
  type        = list(string)
}

# SG
# Default port for App
variable "app_port" {
  description = "Default port for App"
  type        = number
}
# Default port for ABastion Host
variable "sg_port_cidr_bastion" {
  description = "Default port for Bastion"
  type        = map(any)
}
# Default inbound CIDR block
variable "default_cidr" {
  description = "Default CIDR block for IN/OUT traffic"
  type        = string
}
