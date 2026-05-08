terraform {
  backend "s3" {
    bucket = "terraform-tf-storage-bucket"
    key = "vpc-tfstate/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "dynamodb-tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "vpc_01_tf" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    tags = {
        Name = "vpc-s3-connect"
    }
}