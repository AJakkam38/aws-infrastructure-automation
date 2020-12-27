terraform {
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 3.22.0"
      }
  }
}

# Configure the AWS Provider
provider "aws" {
    region = var.AWS_REGION
}

# Create a ec2 instance
resource "aws_instance" "dummy" {
    ami = "ami-0947d2ba12ee1ff75"
    instance_type = "t2.micro"
}