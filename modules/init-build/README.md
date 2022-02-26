# <div align="center">Create initial build for ECR</div>

This module create initial build that build local docker image and push it to ECR repository

Module create null resource with [environment variables](https://github.com/OlesYudin/demo_3/blob/main/modules/init-build/main.tf#:~:text=region%20%20%20%20%20%20%3D%20var.region,image_tag%20%20%20%3D%20var.image_tag "environment variables") that gives to [docker.sh](https://github.com/OlesYudin/demo_3/blob/main/App/docker.sh "docker.sh") script to dynamic build and push to ECR.

## Steps of script

Docker login --> docker local build --> docker push to ECR

## Environments variables

| Value       | Description                                                                                                                                                                     |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Region      | [us-east-2](https://github.com/OlesYudin/demo_3/blob/main/dev.auto.tfvars.example#:~:text=region%20%3D%20%22us%2Deast%2D2%22 "us-east-2")                                       |
| Registry id | [ID of AWS root or user account](https://github.com/OlesYudin/demo_3/blob/main/modules/ecr/output.tf#:~:text=%23%20Output%20regestry%20id,%7D "ID of AWS root or user account") |
| App name    | [`password_generator`](https://github.com/OlesYudin/demo_3/blob/main/dev.auto.tfvars.example#:~:text=app_name%20%20%3D%20%22password%2Dgenerator%22 "password_generator")       |
| Image tag   | [latest](https://github.com/OlesYudin/demo_3/blob/main/dev.auto.tfvars.example#:~:text=image_tag%20%3D%20%22latest%22 "latest")                                                 |

### <div align="center">Scheme of init-build</div>

<p align="center">
  <img src="https://github.com/OlesYudin/demo_3/blob/main/images/Init-build.png" alt="Scheme of init-build"/>
</p>
