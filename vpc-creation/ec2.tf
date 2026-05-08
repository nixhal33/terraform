resource "aws_instance" "sys_server_tf" {
    ami = "ami-091138d0f0d41ff90"
    instance_type = "t3.micro"
    key_name = "nix-vm"
    subnet_id = "${aws_subnet.subnet_01_tf.id}"
    vpc_security_group_ids = [aws_security_group.my_new_sg_tf.id]
    tags = {
        Name = "master-server"
    }
}
