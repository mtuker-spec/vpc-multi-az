# VPC Multi Az

Configuration in this directory creates a VPC with a public/private subnet per availability zone.

There is a public and private subnet created per availability zone in addition to a NAT Gateway and a shared Internet Gateway

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.57 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) | terraform-aws-modules/vpc/aws | 3.7.0 |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description |
|------|-------------|
| <a name="subnet_count"></a> [subnet\_count](#output\_subnet\_count) | Number of the required subnets (between 1 and 3) |

## Outputs

| Name | Description |
|------|-------------|
| <a name="vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="public_subnets_id"></a> [public\_subnets\_id](#output\_public\_subnets) | List of IDs of public subnets |
| <a name="private_subnets_id"></a> [private\_subnets\_id](#output\_private\_subnets) | List of IDs of private subnets |
| <a name="nat_public_ips"></a> [nat\_public\_ips](#output\_nat\_public\_ips) | List of public Elastic IPs created for each AWS NAT Gateway |
| <a name="vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="availability_zones"></a> [availability\_zones](#output\_azs) | A list of the used availability zones |
