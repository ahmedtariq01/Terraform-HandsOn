locals {
  team = "Dev"
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