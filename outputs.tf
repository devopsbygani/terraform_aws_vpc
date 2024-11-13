output "vpc_info" {
  value       = aws_vpc.main.id
  sensitive   = false
}

output "avaiable_zone" {
  value = slice(data.aws_availability_zones.available.names,0,2)
}

output "default_vpc_info" {
  value = data.aws_vpc.default
}

output "routes_table_info" {
  value = data.aws_route_table.main
}

