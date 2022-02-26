# <div align="center">Creating ECR repository</div>

This module create ECR repository with lifecycle policy

| Value              | Description                                                                                                                                                                                              |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Repository name    | [The same name as application](https://github.com/OlesYudin/demo_3/blob/main/dev.auto.tfvars.example#:~:text=app_name%20%20%3D%20%22password%2Dgenerator%22 "The same name as application")              |
| Type of reposiroty | private                                                                                                                                                                                                  |
| Lifecycle policy   | [Keep only 3 last builds](https://github.com/OlesYudin/demo_3/blob/main/modules/ecr/main.tf#:~:text=%22countType%22%3A%20%22imageCountMoreThan%22%2C,%22countNumber%22%3A%203 "Keep only 3 last builds") |
| Access policy      | [Allow clone image to ECS](https://github.com/OlesYudin/demo_3/blob/main/modules/cluster/iam.tf "Allow clone image to ECS") cluster                                                                      |
