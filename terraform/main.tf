terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Local backend — state stored in terraform.tfstate next to this file.
  # To migrate to S3 (Phase 2), replace this block with:
  #
  # backend "s3" {
  #   bucket         = "auditsafely-labs-tfstate"
  #   key            = "terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "auditsafely-labs-tfstate-lock"
  # }
}

provider "aws" {
  region  = var.aws_region
  profile = "auditsafely-labs"
}
