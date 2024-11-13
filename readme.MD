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
