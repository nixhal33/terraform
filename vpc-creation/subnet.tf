resource "aws_subnet" "subnet_01_tf" {
    vpc_id = aws_vpc.vpc_01_tf.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "subnet_01_tf"
    }
}
