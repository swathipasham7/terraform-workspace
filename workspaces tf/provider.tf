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
    bucket            = "myworkspacebucket1"
    key               = "classes/workspace"
    region            = "us-west-2"
    dynamodb_endpoint = "myworkspace"
  }
}

