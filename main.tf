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




