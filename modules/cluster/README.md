# <div align="center">Creating cluster</div>

This module create cluster with Network, SG, Application

## [Application Load Balancer](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/alb.tf "Application Load Balancer")

This load balncer has type **application** and work with **IP-address** of cluster nodes. Load balancer route **HTTP** traffic and work only with 80 port.

## [Elactic Container Service](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/ecs.tf "Elactic Container Service")

ECS create task definition with fargate type and clone docker image from ECR using IAM role.

| Value           | Description                                                                                                                                                                         |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ECS type        | [Fargate](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/ecs.tf#:~:text=requires_compatibilities%20%3D%20%5B%22FARGATE%22%5D "Fargate")                              |
| IAM role        | [IAM](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/iam.tf "IAM")                                                                                                   |
| CPU             | [256mb](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/ecs.tf#:~:text=cpu%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3D%20256 "256mb")        |
| Memory (RAM)    | [512mb](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/ecs.tf#:~:text=memory%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3D%20512 "512mb")              |
| Port            | 80 port                                                                                                                                                                             |
| Platform        | Linux (x86_64)                                                                                                                                                                      |
| Number of nodes | [2](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/ecs.tf#:~:text=launch_type%20%20%20%3D%20%22FARGATE%22-,desired_count%20%3D%202,-network_configuration%20%7B "2") |

## [Identity Access Managment](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/iam.tf "Identity Access Managment")

IAM create 1 role for ECS and attach policy for working with ECR repository

## [Netwotk](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/network.tf "Network")

This module create:

- 1 VPC
- 4 subnets (2 public/2 private) in 2 AZ
- 1 NAT for routing traffic in private subnets
- 1 EIP for NAT

| Value           | Description                                                                                                                                                                                                                                                                                                                                                                                |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| VPC             | [172.31.0.0/16](https://github.com/OlesYudin/demo_3/blob/main/dev.auto.tfvars.example#:~:text=cidr_vpc%20%3D%20%22172.31.0.0/16%22 "172.31.0.0/16")                                                                                                                                                                                                                                        |
| Public Subnets  | [172.31.1.0/24](https://github.com/OlesYudin/demo_3/blob/main/dev.auto.tfvars.example#:~:text=public_subnet%20%3D%20%5B%22172.31.1.0/24%22%2C%20%22172.31.2.0/24%22%5D "172.31.1.0/24"), [172.31.2.0/24](https://github.com/OlesYudin/demo_3/blob/main/dev.auto.tfvars.example#:~:text=public_subnet%20%3D%20%5B%22172.31.1.0/24%22%2C%20%22172.31.2.0/24%22%5D "172.31.2.0/24")           |
| Private Subnets | [172.31.11.0/24](https://github.com/OlesYudin/demo_3/blob/main/dev.auto.tfvars.example#:~:text=private_subnet%20%3D%20%5B%22172.31.11.0/24%22%2C%20%22172.31.12.0/24%22%5D "172.31.11.0/24"), [172.31.12.0/24](https://github.com/OlesYudin/demo_3/blob/main/dev.auto.tfvars.example#:~:text=private_subnet%20%3D%20%5B%22172.31.11.0/24%22%2C%20%22172.31.12.0/24%22%5D "172.31.12.0/24") |

## [Security Group](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/security-group.tf "Security Group")

In this module created 2 SG, 1 for ECS CLuster, 1 for ALB. Both of SG use 80 ports, but in future, for ECS SG will be added 22 port for ssh connection to ECS EC2.
