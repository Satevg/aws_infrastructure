provider "aws" {
  region = "eu-central-1"
  profile = "satevg"
  version = "~> 2.27"
}

terraform {
  backend "s3" {
    key = "terraform.tfstate"
    region = "eu-central-1"
    bucket = "tfstate-lock"
    dynamodb_table = "tfstate-lock-table"
    encrypt = false
  }
}

resource "aws_key_pair" "default_ssh_key" {
  key_name = "ssh_EC2_Key"
  public_key = "${file(var.ssh_public_key)}"
}

resource "aws_instance" "web" {
  ami = "ami-0ac05733838eabc06"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.subnet_first.id}"
  vpc_security_group_ids = ["${aws_security_group.ingress_all.id}"]
  key_name = "${aws_key_pair.default_ssh_key.id}"

  tags = {
    Name = "BaseImage"
  }
}

resource "aws_ebs_volume" "web_ebs_volume" {
  availability_zone = "${aws_instance.web.availability_zone}"
  type = "gp2"
  size = 4

  tags = {
    Name = "Volume for Base EC2 instance"
  }
}

resource "aws_volume_attachment" "example-volume-attachment" {
  device_name = "/dev/sdh"
  instance_id = "${aws_instance.web.id}"
  volume_id   = "${aws_ebs_volume.web_ebs_volume.id}"
}
