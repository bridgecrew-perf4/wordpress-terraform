output "instance_id" {
    value = aws_instance.web_server_ec2.id
    }

output "instance_securitygroup" {
    value = aws_security_group.wp_sg.id
    }

output "aws_db_instance" {
    value = aws_db_instance.rds_db.endpoint  
}
