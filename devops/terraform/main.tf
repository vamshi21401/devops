resource "aws_launch_configuration" "web_server_as" {
image_id = "ami-0e731c8a588258d0d"
instance_type = "t2.micro"
key_name = "ansible"
}

resource "aws_elb" "web_server_lb" {
name = "web-server-lb"
security_groups = [aws_security_group.web_server.id]
subnets = ["subnet-03c56132e625b3ada", "subnet-0e0d23dac85a42572"]
listener {
instance_port = 8000
instance_protocol = "http"
lb_port = 80
lb_protocol = "http"
}
tags = {
Name = "terraform-elb"
}
}

resource "aws_autoscaling_group" "web_server-asg" {
name = "web-server-asg"
launch_configuration = aws_launch_configuration.web_server_as.name
min_size = 1
max_size = 3
desired_capacity = 2
health_check_type = "EC2"
load_balancers = [aws_elb.web_server_lb.name]
availability_zones = ["us-east-1d", "us-east-1c"]
}





