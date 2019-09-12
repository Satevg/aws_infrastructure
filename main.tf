provider "aws" {
  region = "eu-central-1"
  profile = "satevg"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.subnet_first.id}"
  security_groups = ["${aws_security_group.ingress_all.id}"]
  key_name = "sshEC2"

  tags = {
    Name = "BaseImage"
  }
}
