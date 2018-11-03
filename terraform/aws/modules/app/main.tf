provider "aws" {
region = "${var.region}"
access_key = "${var.aws_access_key}"
secret_key = "${var.aws_secret_key}"
}


data "aws_availability_zones" "azs" {}

resource "aws_vpc" "main" {
    cidr_block = "${var.aws_vpc_cidr}"
    instance_tenancy = "default"
    tags {
      name = "Main"
      location = "Mumbai"
    }
 } 


data "aws_subnet_ids" "private" {
    vpc_id = "${aws_vpc.main.id}"
}

data "aws_security_group" "sgids" {
    count = "${length(var.hostnames)}"
    vpc_id = "${aws_vpc.main.id}"
    name = "${element(var.aws_firewall,count.index)}"

}


resource "aws_subnet" "aws_subnets" {
    count = "${length(var.aws_subnets)}"
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${element(var.aws_subnets, count.index)}"    
}

resource "aws_security_group" "security_group" {
    count = "${length(var.aws_firewall)}"
    vpc_id = "${aws_vpc.main.id}"
    name = "${element(var.aws_firewall, count.index)}"
}

resource "aws_instance" "web" {
    count = "${length(var.hostnames)}"
    ami = "${var.aws_ami}"
    associate_public_ip_address = true 
    vpc_security_group_ids = ["${data.aws_security_group.sgids.*.id}"]
    instance_type = "t2.micro"    
   subnet_id     = "${element(data.aws_subnet_ids.private.ids, count.index)}"      
    tags {
        name = "${element(var.hostnames, count.index)}"
    }
 }



#output "instance_ips" {
#    value = ["${aws_instance.web.*.public_ip}"]
#}



