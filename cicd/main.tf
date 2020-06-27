data aws_iam_policy codebuild_admin {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

module iam_codebuild {
  source = "./../module/aws/iam"

  name                          = "continuous-check"
  policy                        = data.aws_iam_policy.codebuild_admin.policy
  principal_service_identifiers = ["codebuild.amazonaws.com"]
}

resource aws_codebuild_project continuous_check {
  // プロジェクトの設定
  name          = var.project_name
  description   = "continuous integration and delivery project for terraform"
  badge_enabled = false
  tags = {
    Description = "terraform ci/cd"
  }

  // ソース
  source {
    type                = "GITHUB"
    location            = "https://github.com/${var.github_repository_owner}/${var.github_repository_name}.git"
    git_clone_depth     = 1
    report_build_status = true // リポジトリ側へ結果通知
    // buildspec
    buildspec = var.buildspec_settings
  }

  // 環境
  environment {
    image           = "hashicorp/terraform:light" // カスタムイメージURL
    type            = "LINUX_CONTAINER"           // 環境タイプ
    compute_type    = "BUILD_GENERAL1_SMALL"      // コンピューティングタイプ
    privileged_mode = false

    // tfnotify用の環境変数
    environment_variable {
      name  = "TF_NOTIFY_REPO_OWNER"
      value = var.github_repository_owner
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "TF_NOTIFY_REPO_NAME"
      value = var.github_repository_name
      type  = "PLAINTEXT"
    }
  }
  // サービスロール
  service_role = module.iam_codebuild.aws_iam_role_arn
  // タイムアウト
  build_timeout = "30"
  // キュータイムアウト
  queued_timeout = "60"

  // アーティファクト
  artifacts {
    type = "NO_ARTIFACTS"
  }

  // キャッシュ
  cache {
    type  = "LOCAL"
    modes = ["LOCAL_SOURCE_CACHE"]
  }

  // ログ
  logs_config {
    cloudwatch_logs {
      status      = "ENABLED"
      group_name  = "mintak"
      stream_name = "continious-check-terraform"
    }

    s3_logs {
      status = "DISABLED"
    }
  }
}

// プライマリソースのウェブフックイベント
resource aws_codebuild_webhook push_event {
  project_name = aws_codebuild_project.continuous_check.name

  // PR作成・更新時
  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PULL_REQUEST_CREATED"
    }
  }

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PULL_REQUEST_UPDATED"
    }
  }

  // developブランチpush時
  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "develop"
    }
  }

  // masterブランチpush時
  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "master"
    }
  }
}
