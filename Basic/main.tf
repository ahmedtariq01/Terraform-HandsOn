# Configuration of the AWS provider
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  default_tags {
    tags = {
      Environment = terraform.workspace
      Provisoned  = "Terraform"
    }
  }

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


# generating a private key
resource "tls_private_key" "my_key" {
  algorithm = "RSA"
}

resource "local_file" "private_my_key" {
  content  = tls_private_key.my_key.private_key_pem
  filename = "myAWSkey.pem"
}

# generating a aws key pair
resource "aws_key_pair" "my_key" {
  key_name   = "myAWSkey"
  public_key = tls_private_key.my_key.public_key_openssh

  lifecycle {
    ignore_changes = [public_key]
  }
}

# adding module block for ec2 instance
module "server" {
  source = "./modules"
  # passing variables to the module
}