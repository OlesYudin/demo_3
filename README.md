# <div align="center">Creating network infrastructure on AWS Cloud Provider using Terraform</div>

In this project was created VPC module with 2 private/public subnets including NAT, EIP, ALB. After creating network infrastructure in local machine build docker image and push to ECR repository. Than, in AWS creates ECS cluster with 2 Fargate nodes and from ECR clone last build and started to run in ECS Fargate Node. This docker image based on alpine image with Apache server. Web-page can generate password for you and show public and private IP-address.

### Structure of modules:

1. [`cluster`](https://github.com/OlesYudin/demo_3/tree/main/modules/cluster "cluster")
   - [`alb.tf`](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/alb.tf "Application Load balancer") balance traffic between different AZ
   - [`ecs.tf`](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/ecs.tf "Elactic Container Service") create task deffenition with ECS Fargate cluster
   - [`iam.tf`](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/iam.tf "Identity Access Managment") create IAM role for ECS and ECR connection
   - [`network.tf`](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/network.tf "Network") create VPC with 2 private/public subnets in 2 AZ. For private subnets was created 1 NAT with elastic IP
   - [`security-group`](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/security-group.tf "security-group") create 2 SG for ALB and application
2. [`ecr`](https://github.com/OlesYudin/demo_3/tree/main/modules/ecr "ecr")
   - [`main.tf`](https://github.com/OlesYudin/demo_3/tree/main/modules/ecr/main.tf "main.tf") create Elastic Container Regestry with lifecycle policy
3. [`init-build`](https://github.com/OlesYudin/demo_3/tree/main/modules/init-build "init-build")
   - [`main.tf`](https://github.com/OlesYudin/demo_3/blob/main/modules/init-build/main.tf "main.tf") create null resource for of docker image and push to ECR
4. [`s3`](https://github.com/OlesYudin/demo_3/tree/main/modules/s3 "s3")
   - [`main.tf`](https://github.com/OlesYudin/demo_3/blob/main/modules/s3/main.tf "main.tf") create s3 bucket with some policy

### <div align="center">Infrastructure scheme</div>

<p align="center">
  <img src="https://github.com/OlesYudin/demo_3/blob/main/images/Network%20infrastructure.jpg" alt="Scheme of creation VPC in AWS"/>
</p>
