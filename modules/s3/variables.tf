# Environment for S3
variable "env" {
  description = "Environment"
  type        = string
}
# Application name
variable "app_name" {
  description = "Default Application name"
  type        = string
}
# AWS profile
variable "aws_user" {
  description = "Profile of AWS"
  type        = string
}
