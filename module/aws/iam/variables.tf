variable role_name {
  type        = string
  description = "IAMロール名称"
}

variable policy_name {
  type        = string
  description = "IAMポリシー名称"
}

variable policy {
  type        = string
  description = "ポリシードキュメント"
}

variable principal_service_identifiers {
  type        = list(string)
  description = "IAMロールを関連付けるサービス識別子リスト"
}
