variable "project" {
    # this is mandatory to be passed by user
}

variable "envirnoment" {
        # this is mandatory to be passed by user
}

variable "vpc_cidr"{
    type = string
    default = "10.0.0.0/16"
}
variable "enable_dns"{
    default = true
}

variable "vpc_tags" {
     default = {}

}

variable "igw_tags" {
     default = {}

}

variable "common_tags" {
    default = {
        terraform = true
    }
}

variable "public_subnet_cidrs" {
    type = list
     validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Please provide 2 subnets ip"
  }
}

variable "public_subnet_tags" {
    default = {}
}

variable "private_subnet_cidr" {
    type = list
     validation {
    condition     = length(var.private_subnet_cidr) == 2
    error_message = "Please provide 2 subnets ip"
  }
}

variable "private_subnet_tags" {
    default = {}
}

variable "database_subnet_cidr" {
    type = list
     validation {
    condition     = length(var.database_subnet_cidr) == 2
    error_message = "Please provide 2 subnets ip"
  }
}
variable "database_subnet_tags" {
    default = {}
}

variable "subnet_group_tags" {
    default = {}
}

variable "public_route_table_tags" {
    default = {}
}

variable "private_route_table_tags" {
    default = {}
}

variable "database_route_table_tags" {
    default = {}
}

variable "peering_tags" {
    default = {}
}

variable "is_peering_requried" {
    default = false
}
