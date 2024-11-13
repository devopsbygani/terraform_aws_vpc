# VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = var.enable_dns

  tags = merge( var.common_tags, var.vpc_tags,
  {
    Name = local.resource_name
  }
  )
}

#internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge( var.common_tags, var.igw_tags,
  {
    Name = local.resource_name
  }
  )
}
# subnets in 2 regions
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index] 
  availability_zone = local.availability_zone[count.index]

  tags = merge( var.common_tags, var.public_subnet_tags,
  {
    Name = "${local.resource_name}-public-${local.availability_zone[count.index]}"
  }
  )
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[count.index] 
  availability_zone = local.availability_zone[count.index]

  tags = merge( var.common_tags, var.private_subnet_tags,
  {
    Name = "${local.resource_name}-private-${local.availability_zone[count.index]}"
  }
  )
}

resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidr[count.index] 
  availability_zone = local.availability_zone[count.index]

  tags = merge( var.common_tags, var.database_subnet_tags,
  {
    Name = "${local.resource_name}-database-${local.availability_zone[count.index]}"
  }
  )
}

# database group for RDS
resource "aws_db_subnet_group" "default" {
  name       = local.resource_name
  subnet_ids = aws_subnet.database[*].id

  tags = merge( var.common_tags, var.subnet_group_tags,
  {
    Name = local.resource_name
  }
  )
}
# Elastic Ip
resource "aws_eip" "nat" {
  domain   = "vpc"
}

#Nat gate way
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id    #elastic ip
  subnet_id     = aws_subnet.public[0].id 
  tags = {
    Name = local.resource_name
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}

# Route Tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge( var.common_tags, var.public_route_table_tags,
  {
    Name = "${local.resource_name}-public"
  }
  )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge( var.common_tags, var.private_route_table_tags,
  {
    Name = "${local.resource_name}-private"
  }
  )
}

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge( var.common_tags, var.database_route_table_tags,
  {
    Name = "${local.resource_name}-database"
  }
  )
}

# Routes
resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.main.id
}

resource "aws_route" "private" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.main.id
}

resource "aws_route" "database" {
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.main.id
}

# Association.
resource "aws_route_table_association" "public" {
  count=length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidr)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
}
