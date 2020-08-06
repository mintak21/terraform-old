variable budget_limit_usd {
  type        = number
  description = "(Required)予算値(USD)"
}

variable budget_name {
  type        = string
  description = "予算名称"
  default     = "mintak-cost-budget"
}

variable budget_notification_email_address {
  type        = string
  description = "通知先のメールアドレス"
  default     = ""
}

