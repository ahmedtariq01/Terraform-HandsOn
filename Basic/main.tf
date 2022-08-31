# Configuration of the AWS provider
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key

}

#Data source: Availablity Zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Data Source: aws region
data "aws_region" "current" {}

# local variables

locals {
  team = "Dev"
}

# creating a S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "My first bucket"
    Environment = local.team
    Region      = data.aws_region.current.name
  }
}

# creating a S3 bucket policy
resource "aws_s3_bucket_acl" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}

# ec2 instance
resource "aws_instance" "web" {
  ami           = var.instance_image # Amazone Machine Image
  instance_type = "t1.micro"

  tags = {
    Name        = var.instance_name
    Environment = local.team
  }
}


