
provider "aws" {
  version = "~> 2.43"
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "tf-state-storage-s3-test"
    key    = "terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "tf-state-lock-dynamo"
    encrypt        = true
  }
}

locals {
 common_tags = {
   Name = "${var.tag_name}"
 }
}

resource "aws_vpc" "test-vpc"{
  cidr_block = "192.168.0.0/16"
}

resource "aws_internet_gateway" "test-igw"{
  vpc_id = aws_vpc.test-vpc.id
}

resource "aws_subnet" "test-subnet"{
  vpc_id = aws_vpc.test-vpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "${var.region}a"
}

resource "aws_route_table" "test-rt"{
  vpc_id = aws_vpc.test-vpc.id
  route {
    cidr_block = var.cidr-0
    gateway_id = aws_internet_gateway.test-igw.id
  }
}

resource "aws_route_table_association" "test-rta"{
  subnet_id = aws_subnet.test-subnet.id
  route_table_id = aws_route_table.test-rt.id
}

resource "aws_eip" "test-eip"{
  vpc = true
  depends_on = [aws_internet_gateway.test-igw]
}

resource "aws_elb" "target-elb" {
  name               = "target-elb"
  security_groups = [aws_security_group.test-nacl-allow-all-out.id]
  subnets = [aws_subnet.test-subnet.id]
###  availability_zones = ["${var.region}a"]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:8080/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "8080"
    instance_protocol = "http"
  }
}

resource "aws_elb" "bastion-elb" {
  name               = "bastion-elb"
  security_groups = [aws_security_group.test-nacl-allow-all-out.id]
  subnets = [aws_subnet.test-subnet.id]
###  availability_zones = ["${var.region}a"]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:8080/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "8080"
    instance_protocol = "http"
  }
}
