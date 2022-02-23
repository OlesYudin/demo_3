# For Network.tf
# Get availability zone
data "aws_availability_zones" "available" {
  state = "available"
}

