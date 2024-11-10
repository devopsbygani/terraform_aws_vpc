variable "project" {
    # this is mandatory to be passed by user
}

variable "envirnoment" {
        # this is mandatory to be passed by user
}

variable "cidr_block"{
    type = string
    default = "10.0.0.0/16"
}
variable "enable_dns"{
    default = true
}

variable "vpc_tag" {
     default = {}

}

variable "igw_tag" {
     default = {}

}

variable "common_tag" {
    default = {
        terraform = true
    }
}

variable "public_subnet_cidr" {
    type = list
     validation {
    condition     = length(var.public_subnet_cidr) == 2
    error_message = "Please provide 2 subnets ip"
  }
}

variable "public_subnet_tag" {
    default = {}
}

variable "private_subnet_cidr" {
    type = list
     validation {
    condition     = length(var.private_subnet_cidr) == 2
    error_message = "Please provide 2 subnets ip"
  }
}

variable "private_subnet_tag" {
    default = {}
}

variable "database_subnet_cidr" {
    type = list
     validation {
    condition     = length(var.database_subnet_cidr) == 2
    error_message = "Please provide 2 subnets ip"
  }
}
variable "database_subnet_tag" {
    default = {}
}

variable "subnet_group_tag" {
    default = {}
}