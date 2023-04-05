variable "region" {
  type = string
}

variable "subnets_info" {
  type = object({
    cidr_ranges = list(string)
    Names       = list(string)
  })
}

variable "ec2_instance" {
  type = object({
    Names     = list(string)
    user_data = list(string)
  })
}