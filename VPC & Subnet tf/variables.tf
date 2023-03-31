variable "region" {
  type    = string
  default = "us-west-2"
}

variable "vpc_cidr_block" {
  type    = string
  default = "198.162.0.0/16"
}

variable "subnet_cidr_block" {
  type    = list(string)
  default = ["198.162.1.0/24", "198.162.2.0/24", "198.162.3.0/24"]
}

variable "availability_zone" {
  type    = list(string)
  default = ["a", "b", "c"]
}

variable "subnet_name" {
  type    = list(string)
  default = ["db1", "db2", "db3"]
}
