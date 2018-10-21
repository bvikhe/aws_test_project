variable "aws_vpc" {}

variable "aws_vpc_cidr" {
}

variable "aws_subnets" {
type = "list"
}

variable "aws_firewall" {
type = "list"
}

variable "aws_ips" {
type = "list"
}

variable "aws_user" {
type = "string"
}

variable "aws_password" {
type = "string"
}

variable "hostnames" {
type = "list"
}

variable "gateway" {}
variable "region" {}
variable "aws_ami" {
type = "string"
}
