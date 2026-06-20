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


# private subnets 
resource "aws_subnet" "private" {
  count              = length(var.private_subnet_cidrs)
  vpc_id             = aws_vpc.main.id
  cidr_block         = var.private_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]


  tags = merge(
     local.commons_tags,
    {
    Name = "${var.project}-${var.environment}-private-${local.az_names[count.index]}"
    },
   var.private_subnet_tags
  )
}

# Database subnet 
resource "aws_subnet" "Database" {
  count              = length(var.Database_subnet_cidrs)
  vpc_id             = aws_vpc.main.id
  cidr_block         = var.Database_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  

  tags = merge(
     local.commons_tags,
    {
    Name = "${var.project}-${var.environment}-Database-${local.az_names[count.index]}"
    },
   var.Database_subnet_tags
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
     local.commons_tags,
    {
    Name = "${var.project}-${var.environment}-public"
    },
   var.public_route_table_tags
  )
  }

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
     local.commons_tags,
    {
    Name = "${var.project}-${var.environment}-private"
    },
   var.private_route_table_tags
  )
  }

  resource "aws_route_table" "Database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
     local.commons_tags,
    {
    Name = "${var.project}-${var.environment}-Database"
    },
   var.Database_route_table_tags
  )
  }

resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id

}

resource "aws_eip" "nat" {
 domain   = "vpc"

 tags = merge(
     local.commons_tags,
    {
    Name = "${var.project}-${var.environment}-nat"
    },
   var.aws_eip_tags
 )
}


resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id


  tags = merge(
     local.commons_tags,
    {
    Name = "${var.project}-${var.environment}"
    },
   var.aws_nat_gateway_tags
  )
  depends_on = [aws_internet_gateway.main]
  }

  resource "aws_route" "private" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main.id

}

resource "aws_route" "Database" {
  route_table_id            = aws_route_table.Database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main.id

}
