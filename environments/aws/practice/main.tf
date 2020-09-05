data aws_ami latest {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource aws_instance tutorial {
  ami           = data.aws_ami.latest.image_id
  instance_type = var.aws_instance_type
  ebs_block_device {
    device_name = "${var.aws_instance_type}-device"
    encrypted   = true
  }
  tags = {
    Name = var.aws_instance_tag_name
  }
}

resource aws_vpc tutorial {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Description = "tutorial"
  }
}
