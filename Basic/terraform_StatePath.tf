#local
#terraform state path
terraform {
  backend "local" {
    path = "terraform_state/terraform.tfstate"
  }
}

# remote state bucket
# terraform {
#   backend "s3" {
#     bucket = bucket_name
#     key    = "terraform.tfstate" #state path
#     region = "us-east-1"  #region
#   }
# }

# terraform state in terraform cloud
# terraform {
#   backend "remote" {
#     hostname = "app.terraform.io"
#     organization = "terraform_handsOn"

#     workspaces {
#       name = "terraform_handsOn_workspace"
#     }
#   }
# }