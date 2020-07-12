variable name {
  type        = string
  description = "関数名"
  default     = "mintak-lambda-function-go"
}

variable handler {
  type        = string
  description = "ハンドラ"
  default     = "main"
}

variable archive_file {
  type        = string
  description = "upload用アーカイブファイル"
}

variable memory {
  type        = number
  description = "メモリ"
  default     = 256
}

variable sns_trigger_enabled {
  type        = bool
  description = "SNS通知をトリガーとするか"
  default     = false
}

variable sns_topic_arn {
  type        = string
  description = "トリガーとしてLambdaへの通知を行うSNSトピックのARN値"
  default     = ""
}

variable slack_channel {
  type        = string
  description = "通知先Slack Channelno"
  default     = ""
}
