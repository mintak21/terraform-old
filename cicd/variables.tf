variable codebuild_project_name {
  type        = string
  description = "CI/CDプロジェクト名称"
  default     = "mintak-terraform-ci-cd"
}

variable codebuild_role_name {
  type        = string
  description = "CodeBuildで使用するIAMロール名称"
  default     = "ServiceRoleForCodeBuildOfContiniousCI"
}

variable codebuild_role_policy_name {
  type        = string
  description = "CodeBuildで使用するIAMロールのもつポリシー名称"
  default     = "CodeBuildOfContiniousCIPolicy"
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
