resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = "true"


tags = local.vpcfinaltags

}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}