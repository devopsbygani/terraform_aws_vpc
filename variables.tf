variable "cidr_block"{
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_tag" {
    # default = "created by mokaganesh"

}

variable "igw_tag" {
    # default = "created by mokaganesh"

}

variable "common_tag" {
    default = {
        project = "expense"
        envirnoment = "dev"
        terraform = true

    }
}