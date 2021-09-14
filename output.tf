#VPC ID
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

#Public Subnet(s) IDs
output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnets
}

#Private Subnet(s) IDs
output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnets
}

#NAT Gateway(s) IDs
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

# CIDR Blocks
output "vpc_cidr_blocks" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

#Avaliability Zones
output "availability_zones" {
  description = "A list of availability deployed availability zones"
  value       = module.vpc.azs
}