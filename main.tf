provider "aws" {
  region = "eu-central-1"
  profile = "satevg"
}

resource "aws_key_pair" "default_ssh_key" {
  key_name = "ssh_EC2_Key"
  public_key = "${file(var.ssh_public_key)}"
}

resource "aws_instance" "web" {
  ami           = "ami-0ac05733838eabc06"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.subnet_first.id}"
  security_groups = ["${aws_security_group.ingress_all.id}"]
  key_name = "${aws_key_pair.default_ssh_key.id}"

  tags = {
    Name = "BaseImage"
  }
}
