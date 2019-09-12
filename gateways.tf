resource "aws_internet_gateway" "base_gateway" {
  vpc_id = "${aws_vpc.default_vpc.id}"
  tags = {
    Name = "Base Gateway"
  }
}