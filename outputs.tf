output "elb_target_name" {
  value = "target - ${aws_elb.target-elb.dns_name}"
}

output "elb_bastion_name" {
  value = "bastion - ${aws_elb.bastion-elb.dns_name}"
}
