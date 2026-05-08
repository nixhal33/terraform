provider "aws" {
    region = "us-east-1"
}

resource "aws_security_group" "new-sg" {
    name = "new-sg-terraform"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 82
        to_port = 82
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "master" {
    ami                    = "ami-091138d0f0d41ff90"
    instance_type          = "t3.micro"
    key_name               = "nix-vm"
    vpc_security_group_ids = [aws_security_group.new-sg.id]

    user_data = <<-EOF
#!/bin/bash
sudo apt update -y
sudo apt install tree zip unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -o awscliv2.zip
sudo ./aws/install --update
rm -rf awscliv2.zip aws/
echo "✅ AWS CLI installed: $(/usr/local/bin/aws --version)"
EOF

    tags = {
        Name = "my-server"
    }
}