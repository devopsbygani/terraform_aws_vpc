resource "aws_vpc" "expense" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true

  tags = merge( var.common_tag, var.vpc_tag,
  {
    Name = "expense"
  }
  )
}

resource "aws_internet_gateway" "expense" {
  vpc_id = aws_vpc.expense.id

  tags = merge( var.common_tag, var.igw_tag,
  {
    Name = "expense"
  }
  )
}


resource "aws_subnet" "expense_public" {
  vpc_id     = aws_vpc.expense.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.example
  tags = {
    Name = "expense-public"
  }
}
