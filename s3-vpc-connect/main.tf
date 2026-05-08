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

resource "aws_vpc" "vpc-1" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    tags = {
        Name = "vpc-s3-connect"
    }
}

resource "aws_subnet" "subnet_01_tf" {
    vpc_id = aws_vpc.vpc-1.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "subnet-1"
    }
}
