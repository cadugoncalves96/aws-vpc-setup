module "vpc" {
  source        = "./modules/vpc"
  tags          = "${var.tags}"
  cidr_block    = "${var.cidr_block}"
}

variable "cidr_block" {}

module "subnets" {
  source             = "./modules/subnets"
  availability_zones = "${var.availability_zones}"
  subnet_cidr_range  = "${var.subnet_cidr_range}"
  tags               = "${var.tags}"
  vpc_id             = "${module.vpc.vpc_id}"
  vpc_cidr           = "${module.vpc.vpc_cidr_block}"
}

module "security" {
  source        = "./modules/security"
  tags          = "${var.tags}"
  vpc_id        = "${module.vpc.vpc_id}"
}

module "gateways" {
  source               = "./modules/gateways"
  availability_zones   = "${var.availability_zones}"
  public_subnet_ids    = "${module.subnets.public_subnet_ids}"
  vpc_id               = "${module.vpc.vpc_id}"
  tags                 = "${var.tags}"
}

module "routing" {
  source              = "./modules/routing"
  vpc_id              = "${module.vpc.vpc_id}"
  tags                = "${var.tags}"
  public_subnet_ids   = "${module.subnets.public_subnet_ids}"
  private_subnet_ids  = "${module.subnets.private_subnet_ids}"
  database_subnet_ids = "${module.subnets.database_subnet_ids}"
  nat_gateway_ids     = "${module.gateways.nat_gateway_ids}"
  internet_gateway_id = "${module.gateways.internet_gateway_id}"
  availability_zones  = "${var.availability_zones}"
}
