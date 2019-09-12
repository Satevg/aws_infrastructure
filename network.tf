resource "aws_vpc" "default_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "Base VPC"
  }
}

resource "aws_eip" "base_ec2_ip" {
  instance = "${aws_instance.web.id}"
  vpc = true
}

output "base_ec2_ip_out" {
  value = "${aws_eip.base_ec2_ip.public_ip}"
}
