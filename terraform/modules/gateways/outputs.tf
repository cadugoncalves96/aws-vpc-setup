output "nat_gateway_ids" {
    value = "${aws_nat_gateway.ngw.*.id}"
}

output "internet_gateway_id" {
    value = "${aws_internet_gateway.igw.id}"
}