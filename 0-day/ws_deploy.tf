provider "aws" {
    region = "us-west-2"
}

resourse "aws_security_group" "server_secgroup" {
    name = "ws security group"
    
    ingress {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_block = ["0.0.0.0/0"]
    }
    
    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_block = ["0.0.0.0/0"]
    }    

resource "aws_instance" "web_server_ec2" {
    ami = "ami-0d527b8c289b4af7f"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_securitygroup.server_secgroup.id]
    user_data = <<EOF
        sudo apt update
        sudo apt install nginx
        sudo systemctl enable nginx
>>EOF
}

resource "aws_securitygroup" "wp_sg" {
    name = "wp_sg"

    dynamic "ingress" {
        for_each = ["80", "443", "22"]    
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = "[0.0.0.0/0]"
        }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = "[0.0.0.0/0]"
   }
}
    
outout "instance_id" {
    value = aws_instance.web_server_ec2.id
    }
        
