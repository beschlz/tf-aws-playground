terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "besch-cc-tf-state-backend"
    key = "tf-state"
    region = "eu-central-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}

# bucket configuration
resource "aws_s3_bucket" "tf-state-bucket-backend" {
  bucket = "besch-cc-tf-state-backend"
}

# enable versioning for the bucket
resource "aws_s3_bucket_versioning" "tf-state-bucket-versioning" {
  bucket = aws_s3_bucket.tf-state-bucket-backend.id

  versioning_configuration {
    status = "Enabled"
  }
}

# enable server side encryption for the bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "tf-state-bucket-encryption" {
  bucket = aws_s3_bucket.tf-state-bucket-backend.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

