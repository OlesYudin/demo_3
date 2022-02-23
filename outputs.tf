# Output VPC CIDR
output "vpc_ip" {
  value = module.cluster.vpc_ip
}
# Output Public Elastic IP
output "eip_public_ip" {
  value = module.cluster.eip_public_ip
}
# Output DNS name of ALB
output "alb_dns" {
  value = module.cluster.alb_dns
}
# Output registry ID
output "registry_id" {
  value = module.ecr.registry_id
}
# Output registry URL
output "registry_url" {
  value = module.ecr.registry_url
}
# Output URL of S3 Bucket
output "s3_bucket_url" {
  value = module.s3.s3_bucket_url
}
