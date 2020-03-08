resource "aws_launch_template" "bastion_asg_lt" {
  image_id      = data.aws_ami.test-ami.id
  instance_type = "t2.micro"
  key_name = "test key name"
  network_interfaces {
    security_groups = [aws_security_group.test-nacl-allow-all-out.id]
    associate_public_ip_address = true
  }
  monitoring {
    enabled = true
  }
  placement {
    availability_zone = "${var.region}a"
  }
}

resource "aws_launch_template" "target_asg_lt" {
  image_id      = data.aws_ami.test-ami.id
  instance_type = "t2.micro"
  key_name = "test key name"
  network_interfaces {
      security_groups = [aws_security_group.test-nacl-allow-all-out.id]
  }
  monitoring {
    enabled = true
  }
  placement {
    availability_zone = "${var.region}a"
  }
}

resource "aws_autoscaling_group" "bastion-asg" {
  max_size           = 3
  min_size           = 1
  name = "bastion-asg"
  vpc_zone_identifier = [aws_subnet.test-subnet.id]
  depends_on = [aws_elb.bastion-elb]
  load_balancers = [aws_elb.bastion-elb.id]
  health_check_type    = "EC2"
  termination_policies = ["OldestInstance"]
  launch_template {
    id      = aws_launch_template.bastion_asg_lt.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "target-asg" {
  max_size           = 3
  min_size           = 1
  name = "target-asg"
  vpc_zone_identifier = [aws_subnet.test-subnet.id]
  depends_on = [aws_elb.target-elb]
  load_balancers = [aws_elb.target-elb.id]
  health_check_type    = "EC2"
  termination_policies = ["OldestInstance"]
    launch_template {
    id      = aws_launch_template.target_asg_lt.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "bastion-asg-pol" {
  name                   = "bastion-asg-pol"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "bastion-asg"
  depends_on = [aws_autoscaling_group.bastion-asg]
}

resource "aws_autoscaling_policy" "target-asg-pol" {
  name                   = "target-asg-pol"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "target-asg"
  depends_on = [aws_autoscaling_group.target-asg]
}
