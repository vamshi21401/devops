resource "aws_s3_bucket" "one" {
bucket = "vamshi_ccit.bucket"
}

resource "aws_s3_bucket_ownership_controls" "two" {
bucket = aws_s3_bucket.one.id
rule {
object_owership = "BucketOwnerPreferred"
}
}
resource "aws_s3_bucket_acl" "three" {
depends_on = [aws_s3_bucket_ownership_controls.two]

bucket = aws_s3_bucket.one.id
acl = "private"
}
resource "aws_s3_bucket_versioning" "three" {
bucket = aws_s3_bucket.one.id
versioning_configuration {
status = "Enabled"
}
}
terraform {
backend "s3" {
bucker = "vamshi_ccit.bucket"
key = "prod/terrafrom.tfstate"
region = "us-east-1"
}
}
