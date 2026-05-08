resource "aws_route_table" "rt_tf" {
    vpc_id = aws_vpc.vpc_01_tf.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw_tf.id
    }
    tags = {
      Name = "public-route-table"
    }
}

resource "aws_route_table_association" "rt_subnet" {
    subnet_id = aws_subnet.subnet_01_tf.id
    route_table_id = aws_route_table.rt_tf.id
}