region = "us-east-1"
subnets_info = {
  Names       = ["web", "db"]
  cidr_ranges = ["10.0.0.0/24", "10.0.1.0/24"]
}
ec2_instance = {
  Names     = ["Nginx", "Apache2"]
  user_data = ["nginx.sh", "apache.sh"]
}  