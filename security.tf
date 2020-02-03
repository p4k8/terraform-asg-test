resource "aws_security_group" "test-nacl-allow-all-out" {
  name = "Allow All Out Sec Group"
  description = "All out/ ssh in traffic is allowed"
  vpc_id = aws_vpc.test-vpc.id

  egress {
    protocol = "-1"
    cidr_blocks = [var.cidr-0]
    from_port = 0
    to_port = 0
  }

  ingress {
    protocol = "tcp"
    cidr_blocks = [var.cidr-0]
    from_port = 22
    to_port = 22
  }

  tags = local.common_tags
}

resource "aws_network_acl" "test-nacl-allow-all" {
  vpc_id = aws_vpc.test-vpc.id

  egress {
    protocol = "-1"
    rule_no = 100
    action = "allow"
    cidr_block = var.cidr-0
    from_port = 0
    to_port = 0
  }

  ingress {
    protocol = "-1"
    rule_no = 200
    action = "allow"
    cidr_block = var.cidr-0
    from_port = 0
    to_port = 0
  }

   tags = local.common_tags
}

resource "aws_key_pair" "test-kp"{
  key_name = "test key name"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCyfHspMlLqYyvf08gMYoVdQRN26v2+ORbcoxF1/w7LLKPt4iK2qiEWTX594cZ5nDE4dbSd00y5it1HBjQHd8ijHsF+P2os3G3hUQnM5cEJiZlL7uhH8K/GxSv+sn1LJEVn1IDOWORRT7EssWUznk8XT3udGz1HqE/tv3/Gz4BqVMmqzVZU1HGV1YWDOrJg1VKuQxRPJndBe+Q5xWJ1QNnfin/ADj+ZVrpvS5yTocNjMCcNXAZbDllVYmcDq7ywcHhF/kbjAJB0PY3owBCYKOehfpLfGZZPJk/kxvc4KN9gFxFTFz9F6P8di67Q1ZShVsxX2G24caDh/LGp39MK3L0a6YBZkomo+l6dL9eTB+adoeSsEli0/31RCK3/YQc+7vOuyElLUFhOvlLnrLk0BpNBhveGsMieTprxf2r++Pc+0EKlV5RVhQmao30UFn0nvLXSeL4B6uOH5ktC5Xc/80njGX9Vxgu+29Npy31zE2m6Ewq7JqixzvtfCiLxvLwUyL8="
}

