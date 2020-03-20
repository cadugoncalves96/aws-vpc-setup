resource "aws_route_table" "public-rt" {

  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.internet_gateway_id}"
  }

   tags = "${var.tags}"

}

resource "aws_route_table_association" "public-rt-association" {
  count           = "${length(var.availability_zones)}"
  subnet_id       = "${element(var.public_subnet_ids, count.index)}"
  route_table_id  = "${aws_route_table.public-rt.id}"
}

resource "aws_route_table" "private-rt" {
  count  = "${length(var.availability_zones)}"
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${element(var.nat_gateway_ids, count.index)}"
  }

  tags = "${var.tags}"

}

resource "aws_route_table_association" "private-rt-association" {
  count           = "${length(var.availability_zones)}"
  subnet_id       = "${element(var.private_subnet_ids, count.index)}"
  route_table_id  = "${element(aws_route_table.private-rt.*.id, count.index)}"
}

resource "aws_route_table" "database-rt" {
  count  = "${length(var.availability_zones)}"
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${element(var.nat_gateway_ids, count.index)}"
  }

  tags = "${var.tags}"

}

resource "aws_route_table_association" "database-rt-association" {
  count           = "${length(var.availability_zones)}"
  subnet_id       = "${element(var.database_subnet_ids, count.index)}"
  route_table_id  = "${element(aws_route_table.database-rt.*.id, count.index)}"
}