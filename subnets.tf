resource "aws_subnet" "subnet_first" {
  cidr_block = "${cidrsubnet(aws_vpc.default_vpc.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.default_vpc.id}"
  availability_zone = "eu-central-1a"
}

resource "aws_route_table" "route_table_main" {
  vpc_id = "${aws_vpc.default_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.base_gateway.id}"
  }
  tags = {
    Name = "Base Route Table"
  }
}
resource "aws_route_table_association" "subnet_association" {
  subnet_id = "${aws_subnet.subnet_first.id}"
  route_table_id = "${aws_route_table.route_table_main.id}"
}
