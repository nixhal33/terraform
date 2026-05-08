provider "aws" {
    region = "us-east-1"
}

data "aws_security_group" "sg" {
    filter {
      name = "group-name"
      values = ["launch-wizard-1"]
    }
}

resource "aws_instance" "master" {
    ami = "ami-091138d0f0d41ff90"
    instance_type = "t3.micro"
    key_name = "nix-vm"
    vpc_security_group_ids = [data.aws_security_group.sg.id]
    user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install -y gnupg software-properties-common wget
    wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com noble main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt-get update -y
    sudo apt-get install terraform -y
    terraform --version > /home/ubuntu/tf-version.txt
    EOF

    tags = {
        Name = "TF-server"
    }
}
