resource "aws_nat_gateway" "ngw" {
  depends_on    = ["aws_eip.ngw_eips"]
  count         = "${length(var.availability_zones)}"
  allocation_id = "${element(aws_eip.ngw_eips.*.id, count.index)}"
  subnet_id     = "${element(var.public_subnet_ids, count.index)}"
  tags          = "${var.tags}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id    = "${var.vpc_id}"
  tags      = "${var.tags}"
}

resource "aws_eip" "ngw_eips" {
  count = "${length(var.availability_zones)}"
  vpc   = true
  tags  = "${var.tags}"
}