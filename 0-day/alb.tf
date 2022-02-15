data "aws_subnet_ids" "default" {
    vpc_id = data.aws_vpc.default.id
}

resource "aws_lb" "wp_alb" {
    name                   = "wp-balancer"
    loadload_balancer_type = "application"
    subnets                = data.aws_subnet_ids
    security_groups        = [aws_security_group.alb_sg.id]
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.wp_alb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type = "fixed-response"

        fixed_response {
            content_type = "text/plain"
            message_body = "404: page not found"
            status_code  = 404
        }
    }
}

resource "aws_security_group" "alb_sg" {
    name = "load balances sg"
    ingress {
        from_port = 80
        to_port   = 80
        protocol  = "-1"
        cidr_bloks = ["0.0.0.0/0"]
    }
}

resource "aws_lb_target_group " "asg" {
    name          = "wp_targetgroup"
    port          = 80
    protocol      = "HTTP"
    vpc_id        = data.aws_subnet_ids.default.idconnection

    health_check {
        path      = "/"
        protocol  = "HTTP"
        matcher   = "200"
        interval  = 15
        timeout   = 3
        healthy_threshold = 2
        unhealthy_threshold =2
    } 
}
