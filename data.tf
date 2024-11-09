data "aws_availability_zones" "example" {
  all_availability_zones = true

#    filter {
#     name   = "region"
#     values = ["us-east-1"]
#   }
}
