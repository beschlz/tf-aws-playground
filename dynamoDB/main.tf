terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "besch-cc-tf-state-backend"
    key = "tf_dynamodb_example"
    region = "eu-central-1"
  }
}

resource "aws_dynamodb_table" "pets" {
    name = "Pets"
    billing_mode = "PROVISIONED"
    read_capacity = 1
    write_capacity = 1
    hash_key = "PetID"
    range_key = "PetType"

    attribute {
      name = "PetID"
      type = "N"
    }

    attribute {
      name = "PetType"
      type = "S"
    }
}



