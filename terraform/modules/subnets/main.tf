resource "aws_subnet" "public-subnet" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr,var.subnet_cidr_range,count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = "${var.tags}"
}

resource "aws_subnet" "private-subnet" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr,var.subnet_cidr_range,count.index + length(var.availability_zones))}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = "${var.tags}"
}

resource "aws_subnet" "database-subnet" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr,8,count.index + 2 + length(var.availability_zones))}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = "${var.tags}"
}