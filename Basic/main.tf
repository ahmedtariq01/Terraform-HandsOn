# provider: aws
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.27.0"
    }
  }
}

# local variable
locals {
  team = "Dev"
}


# Configuration of the AWS provider
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key

}


# creating a S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "My first bucket"
    Environment = local.team
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


