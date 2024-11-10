resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = var.enable_dns

  tags = merge( var.common_tag, var.vpc_tag,
  {
    Name = local.resource_name
  }
  )
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge( var.common_tag, var.igw_tag,
  {
    Name = local.resource_name
  }
  )
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index] 
  availability_zone = local.availability_zone[count.index]

  tags = merge( var.common_tag, var.public_subnet_tag,
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

  tags = merge( var.common_tag, var.private_subnet_tag,
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

  tags = merge( var.common_tag, var.database_subnet_tag,
  {
    Name = "${local.resource_name}-database-${local.availability_zone[count.index]}"
  }
  )
}

resource "aws_db_subnet_group" "default" {
  name       = local.resource_name
  subnet_ids = aws_subnet.database[*].id

  tags = merge( var.common_tag, var.subnet_group_tag,
  {
    Name = local.resource_name
  }
  )
}

resource "aws_eip" "nat" {
  domain   = "vpc"
}

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

