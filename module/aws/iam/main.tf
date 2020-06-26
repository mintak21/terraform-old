# 信頼ポリシー：どのサービスに関連付けるか
data aws_iam_policy_document assume_role {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.principal_service_identifiers
    }
  }
}

# IAMロール
resource aws_iam_role this {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# IAMポリシー
resource aws_iam_policy this {
  name   = "ServiceRole_${var.name}"
  policy = var.policy
}

# IAMロールとポリシーの紐付け
resource aws_iam_role_policy_attachment this {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
