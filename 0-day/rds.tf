variable "db_password" {
    type                 = string
}
resource "aws_db_instance" "rds_db" {
    allocated_storage    = 20
    engine               = "mysql"
    engine_version       = "5.7"
    instance_class       = "db.t2.micro"
    name                 = "mydb"
    username             = "mysqladmin"
    password             = var.db_password
    parameter_group_name = "default.mysql5.7"
    skip_final_snapshot  = true  
}