resource "aws_security_group" "albsg" {
    vpc_id = var.vpc_id

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 80
        to_port = 80
        protocol = "HTTP"
       
    }

        ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 443
        to_port = 443
        protocol = "HTTPS"
    }

     egress {
        cidr_blocks = ["0.0.0.0/0"]
        to_port = 0
        from_port = 0
        protocol = "-1"
    }

    name = "${var.project_name}-albsg"
  
}

resource "aws_security_group" "websg" {
    vpc_id = var.vpc_id

    ingress {
        security_groups = [ aws_security_group.albsg.id ]
        from_port = 80
        to_port = 80
        protocol = "HTTP"
    }

    egress {
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "-1"
        from_port = 0
        to_port = 0
    }

    name = "${var.project_name}-webbsg"
}

resource "aws_security_group" "dbsg" {
    vpc_id = var.vpc_id

    ingress {
        security_groups = [ aws_security_group.websg.id ]
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
    }

    egress {
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "-1"
        from_port = 0
        to_port = 0
    }

    name = "${var.project_name}-dbsg"
}