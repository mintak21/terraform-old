variable email_address {
  type        = string
  description = "通知先メールアドレス" # set by tfvars
}

variable slack_token {
  type        = string
  description = "連携先Slackトークン" # set by tfvars
}

variable slack_notification_channel {
  type        = string
  description = "通知先Slack Channel"
  default     = "#notifications"
}

variable lambda_file {
  type        = string
  description = "通知用Lambdaのバイナリファイル"
  default     = "archive/notifier"
}
