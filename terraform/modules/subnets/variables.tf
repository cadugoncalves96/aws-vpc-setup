variable "vpc_id" {}
variable "availability_zones" {}
variable "tags" {}
variable "subnet_cidr_range" {
    description = "The multiplier for the cidr separation."
    default = 8
}

variable "vpc_cidr" {}
