provider "aws" {
    region = "us-west-2"
}    

resource "aws_instance" "web_server_ec2" {
    ami = "ami-0ac73f33a1888c64a"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_securitygroup.wp_sg.id]
    user_data = <<EOF
sudo apt update
sudo apt install nginx
sudo systemctl enable nginx
>>EOF
}

resource "aws_securitygroup" "wp_sg" {
    name = "wp_sg"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = "[0.0.0.0/0]"
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = "[0.0.0.0/0]"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = "[0.0.0.0/0]"
   }
}
