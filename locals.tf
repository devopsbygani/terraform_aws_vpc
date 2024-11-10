locals {
    resource_name = "${var.project}-${var.envirnoment}"
    availability_zone = slice(data.aws_availability_zones.available.names,0,2)

}