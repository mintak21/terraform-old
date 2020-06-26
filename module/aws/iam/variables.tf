variable name {
  type        = string
  description = "ロール/ポリシー名称"
}

variable policy {
  type        = string
  description = "ポリシードキュメント"
}

variable principal_service_identifiers {
  type        = list(string)
  description = "IAMロールを関連付けるサービス識別子リスト"
}
