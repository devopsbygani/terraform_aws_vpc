output "vpc_info" {
  value       = aws_vpc.main.id
  sensitive   = false
}

output "avaiable_zone" {
  value = slice(data.aws_availability_zones.available.names,0,2)
}

# default vpc info.
output "default_vpc_info" {
  value = data.aws_vpc.default
}

#deafult vpc route table info for peering 
output "routes_table_info" {
  value = data.aws_route_table.main
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  value = aws_subnet.database[*].id
}

output "database_subnet_group_name" {
  value = aws_db_subnet_group.default.name
}

