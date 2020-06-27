output aws_instance_info {
  value = <<EOF

    ami : ${aws_instance.tutorial.ami}
    arn : ${aws_instance.tutorial.arn}
    private_ip: ${aws_instance.tutorial.private_ip}
    public_ip: ${aws_instance.tutorial.public_ip}
EOF
}
