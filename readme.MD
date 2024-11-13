# VPC module .
# This module will create below mentioned resources in aws. for High availabilty we are creating it in first 2 Available zones.

* VPC
* Internet Gateway.
* public subnets in 2 AZ.
* private subnets in 2 AZ.
* Database subnets in 2 AZ.
* Database subnet group.
* Elastic IP
* Nat Gateway.
* Public Route table.
* private Route table.
* database Route table.
* Routes 
* Association of Route tables with subnets.
* Peering with default VPC(if Required).
* Peering routes in acceptor and requestor route tables.

# Inputs

* Project (mandatory) : name of the project, type is string.
* environment (mandatory) : name of the enviroment, type is string.
* cidr_block (optional) : default value is "10.0.0.0/16".
* enable_dns_hostnames(optional) : default value is true
* vpc_tags (optional) : default is empty , type is map
* igw_tags (optional) : default is empty , type is map
* common_tags (optional): default is empty , type is map
* public_subnet_cidr (mandatory) : User has to provide 2 subnet ip's .
* public_subnet_tags (optional) : default is empty , type is map
* private_subnet_cidr (mandatory) : User has to provide 2 subnet ip's .
* private_subnet_tags (optional) : default is empty , type is map
* database_subnet_cidr (mandatory) : User has to provide 2 subnet ip's .
* database_subnet_tags (optional) : default is empty , type is map.
* subnet_group_tags (optional) : default is empty , type is map.
* public_route_table_tags (optional) : default is empty , type is map.
* private_route_table_tags (optional): default is empty , type is map.
* database_route_table_tags (optional): default is empty , type is map.
* peering_tags (optional): default is empty , type is map.
* is_peering_requried (optional) : default value is false.