variable project_name {
  type        = string
  description = "CI/CDプロジェクト名称"
  default     = "mintak-terraform-ci-cd"
}

variable buildspec_settings {
  type        = string
  description = "ビルド仕様"
  default     = "cicd/buildspec.yml"
}

variable github_repository_location {
  type        = string
  description = "連携するGithubのURL(.git形式)"
}
