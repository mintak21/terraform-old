output codebuild_continuous_check_arn {
  value = aws_codebuild_project.continuous_check.arn
  description = "IAMロールのarn値"
}
