resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = "true"


  tags = local.vpcfinaltags

}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = local.igw_final_tags

}
# pulic subnets 
resource "aws_subnet" "public" {
  count              = length(var.public_subnet_cidrs)
  vpc_id             = aws_vpc.main.id
  cidr_block         = var.public_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true

  tags = merge(
     local.commons_tags,
    {
    Name = "${var.project}-${var.environment}-public-${local.az_names[count.index]}"
    },
   var.public_subnet_tags
  )
}
