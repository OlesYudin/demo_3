# Create S3 bucket
resource "aws_s3_bucket" "s3_tf_state" {
  bucket        = "${var.env}-demo-s3-${var.app_name}-${var.aws_user}-bucket"
  force_destroy = true

  tags = {
    Name        = "${var.env}-${var.app_name}-bucket"
    Description = "S3 bucket for tf state files in dev env"
  }
}
# Add versioning in Bucket
resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.s3_tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "s3_tf_state_acl" {
  bucket = aws_s3_bucket.s3_tf_state.id
  acl    = "private"
}
