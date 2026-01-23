terraform {
  backend "s3" {
    bucket         = "sam-shop-now-state"
    key            = "terraform/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "sam-terraform-stack" # Partition name is "LockID" in S3
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}




