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
# module "server" {
#   source = "./modules/server"
#   # passing variables to the module
# }

# # adding module block for ec2 instance
# module "aws_s3_bucket" {
#   source = "./modules/bucket"
#   # passing variables to the module
# }