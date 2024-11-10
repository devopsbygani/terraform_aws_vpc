resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = var.enable_dns

  tags = merge( var.common_tag, var.vpc_tag,
  {
    Name = local.resource_name
  }
  )
}

resource "aws_internet_gateway" "expense" {
  vpc_id = aws_vpc.expense.id

  tags = merge( var.common_tag, var.igw_tag,
  {
    Name = local.resource_name
  }
  )
}


resource "aws_subnet" "expense_public" {
  vpc_id     = aws_vpc.expense.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.example.names[0]
  tags = {
    Name = "expense-public"
  }
}
