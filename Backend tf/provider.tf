terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket         = "mybackendterraform"
    dynamodb_table = "mydynamodbtable"
    key            = "classes/BACKENDTF"
    region         = "us-west-2"
  }
}
