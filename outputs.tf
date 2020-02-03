
output "elb_dns_name" {
  value = "${aws_elb.test-elb.dns_name}"
}
