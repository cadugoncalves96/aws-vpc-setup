output "public_subnet_ids" {  
   value = "${aws_subnet.public-subnet.*.id}"
}

output "private_subnet_ids" {  
   value = "${aws_subnet.private-subnet.*.id}"
}

output "database_subnet_ids" {  
   value = "${aws_subnet.database-subnet.*.id}"
}

output "public_cidrs" {  
   value = "${aws_subnet.public-subnet.*.cidr_block}"
}

output "private_cidrs" {  
   value = "${aws_subnet.private-subnet.*.cidr_block}"
}

output "database_cidrs" {  
   value = "${aws_subnet.database-subnet.*.cidr_block}"
}