outout "instance_id" {
    value = aws_instance.web_server_ec2.id
    }

outout "instance_securitygroup" {
    value = aws_security_group.web_server_ec2.id
    }
