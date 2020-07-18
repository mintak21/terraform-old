variable alarm_name {
  type        = string
  description = "アラーム名称"
}

variable namespace {
  type        = string
  description = "請求額をチェックしたいAWSサービス名称"
  # refs. https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/monitoring/appinsights-logs-and-metrics.html
}

variable maximum_amount {
  type        = number
  description = "金額しきい値"
  default     = 1
}

variable currency {
  type        = string
  description = "金額の表す通貨単位"
  default     = "USD"
}

variable email_address {
  type        = string
  description = "通知先メールアドレス"
}
