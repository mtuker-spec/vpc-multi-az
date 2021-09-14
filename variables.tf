variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-west-2"
}
variable "subnet_count" {
  description = "Number of subnets required"
  type        = number
  default     = 2

  validation {
    condition     = var.subnet_count > 0 && var.subnet_count <= 3
    error_message = "Please provide a valid number for subnet(s) creation (between 1 and 3)."
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  vpc_name            = "vpc-multi-az"
  vpc_cidr_block      = "10.0.0.0/16"
  security_group_name = "multi-az-sc"

  # In this case it's always better to work with local variables
  availability_zones = data.aws_availability_zones.available.names

  security_group_rules = {

    ingress = [
      {
        protocol  = "tcp"
        self      = true
        from_port = 443
        to_port   = 443
      }
    ]
    egress = [
      {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
      }
    ]
  }

  network_acls = {

    public_inbound = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
    ]
    public_outbound = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
    ]
    private_inbound = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
    ]
    private_outbound = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      }
    ]
  }

  private_subnets_cidr = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]

  public_subnets_cidr = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24"
  ]
}
