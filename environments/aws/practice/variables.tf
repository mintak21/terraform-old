variable aws_instance_type {
  type        = string
  description = "AWSインスタンス種別"
  default     = "t2.micro"
}

variable aws_instance_tag_name {
  type        = string
  description = "AWSインスタンスタグ：Name"
  default     = "terraform-tutorial"
}
