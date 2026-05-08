resource "aws_internet_gateway" "igw_tf" {
    vpc_id = aws_vpc.vpc_01_tf.id
    tags = {
      Name = "public igw tf"
    }
  
}