module "app" {
  source = "modules/app"
  gateway = "${var.gateway}"
  aws_firewall = "${var.aws_firewall}"
  aws_ips = "${var.aws_ips}"
  aws_user = "${var.aws_user}"
  hostnames = "${var.hostnames}"
  region = "${var.region}"
  aws_vpc = "${var.aws_vpc}"
  aws_subnets = "${var.aws_subnets}"
  aws_password = "${var.aws_password}"
  aws_vpc_cidr = "${var.aws_vpc_cidr}"
  aws_ami = "${var.aws_ami}"
}

output "instance_ips" {
value = "${module.app.instance_ips}"
}
