output continuous_check_aws_codebuild_project_arn {
  value       = aws_codebuild_project.continuous_check.arn
  description = "CodeBuildプロジェクトのarn値"
}
