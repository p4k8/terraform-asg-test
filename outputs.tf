output "elb_dns_name" {
  value = "target - ${aws_elb.target-elb.dns_name} bastion - ${aws_elb.bastion-elb.dns_name}"
}
