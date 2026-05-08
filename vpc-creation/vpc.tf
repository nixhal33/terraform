resource "aws_vpc" "vpc_01_tf" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    tags = {
        Name = "vpc_01_tf"
    }
}