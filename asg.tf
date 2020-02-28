resource "aws_launch_configuration" "bastion_asg_lt" {
  image_id      = data.aws_ami.test-ami.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.test-nacl-allow-all-out.id]
  key_name = "test key name"
  associate_public_ip_address = true
}

resource "aws_launch_configuration" "target_asg_lt" {
  image_id      = data.aws_ami.test-ami.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.test-nacl-allow-all-out.id]
  key_name = "test key name"
  associate_public_ip_address = false
}

resource "aws_autoscaling_group" "bastion-asg" {
  availability_zones = ["${var.region}a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  vpc_zone_identifier = [aws_subnet.test-subnet.id]
  depends_on = [aws_elb.bastion-elb]
  load_balancers = [aws_elb.bastion-elb.id]
  launch_configuration = aws_launch_configuration.bastion_asg_lt.id
}

resource "aws_autoscaling_group" "target-asg" {
  availability_zones = ["${var.region}a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  vpc_zone_identifier = [aws_subnet.test-subnet.id]
  depends_on = [aws_elb.target-elb]
  load_balancers = [aws_elb.target-elb.id]
  launch_configuration = aws_launch_configuration.target_asg_lt.id
}
