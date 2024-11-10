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