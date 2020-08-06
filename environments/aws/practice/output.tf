output tutorial_aws_instance_info {
  description = "EC2インスタンス情報"
  value       = <<EOF

    ami : ${aws_instance.tutorial.ami}
    arn : ${aws_instance.tutorial.arn}
    private_ip: ${aws_instance.tutorial.private_ip}
    public_ip: ${aws_instance.tutorial.public_ip}
EOF
}

output tutorial_aws_vpc_info {
  description = "VPC情報"
  value       = <<EOF

    arn : ${aws_vpc.tutorial.arn}
    cidr_block: ${aws_vpc.tutorial.cidr_block}
    owner_id: ${aws_vpc.tutorial.owner_id}
EOF
}
