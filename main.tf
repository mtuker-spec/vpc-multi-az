provider "aws" {
  region = var.aws_region
}

resource "aws_eip" "nat" {
  count = var.subnet_count
  vpc   = true
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.7.0"

  name = local.vpc_name
  cidr = local.vpc_cidr_block

  # Availability Zones
  azs = slice(local.availability_zones, 0, var.subnet_count)

  # Subnets
  private_subnets = slice(local.private_subnets_cidr, 0, var.subnet_count)
  public_subnets  = slice(local.public_subnets_cidr, 0, var.subnet_count)

  # Internet Gateway
  create_igw = true

  # NAT Gateway
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
  external_nat_ip_ids    = aws_eip.nat.*.id

  # ACL
  public_dedicated_network_acl  = true
  private_dedicated_network_acl = true

  public_inbound_acl_rules  = local.network_acls.public_inbound
  public_outbound_acl_rules = local.network_acls.public_outbound

  private_inbound_acl_rules  = local.network_acls.private_inbound
  private_outbound_acl_rules = local.network_acls.private_outbound

  # Security Group
  manage_default_security_group  = true
  default_security_group_name    = local.security_group_name
  default_security_group_ingress = local.security_group_rules.ingress
  default_security_group_egress  = local.security_group_rules.egress

  # Flow Log
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  # Tags
  public_subnet_tags = {
    Name = "public-subnet"
  }

  private_subnet_tags = {
    Name = "private-subnet"
  }

  vpc_tags = {
    Name = local.vpc_name
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
