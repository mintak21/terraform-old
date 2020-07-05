output vpc_development_aws_vpc_basic_info {
  description = "https://github.com/terraform-aws-modules/terraform-aws-vpc#outputs"
  value       = <<EOF

    vpc_arn : ${module.vpc_development.vpc_arn}
    vpc_cidr_block : ${module.vpc_development.vpc_cidr_block}
    default_vpc_cidr_block : ${module.vpc_development.default_vpc_cidr_block}
EOF
}
