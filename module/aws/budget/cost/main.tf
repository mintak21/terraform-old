resource aws_budgets_budget this {
  name              = var.budget_name
  budget_type       = "COST"
  limit_amount      = var.budget_limit_usd
  limit_unit        = "USD"
  time_period_start = "2019-10-01_00:00"
  # time_period_endを設定すると期限切れ予算、設定しないと定期予算の扱い
  time_unit = "MONTHLY" # 間隔（月別）

  # 詳細オプション / コンソールから作成する際のデフォルト値にあわせている
  cost_types {
    use_blended                = false # 非ブレンドコスト
    use_amortized              = false # 非償却コスト
    include_refund             = false # 返金
    include_credit             = false # クレジット
    include_upfront            = true  # 前払いの予約料金
    include_recurring          = true  # 定期的な予約料金
    include_subscription       = true  # サブスクリプションコスト
    include_other_subscription = true  # そのほかのサブスクリプションコスト
    include_tax                = true  # 税金
    include_support            = true  # サポートの料金
    include_discount           = true  # 割引
  }

  notification {
    # 実際のコストが予算の80%を超えたときに通知
    notification_type          = "ACTUAL"
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    subscriber_email_addresses = ["${var.budget_notification_email_address}"]
    subscriber_sns_topic_arns  = ["${aws_sns_topic.this.arn}"]
  }
}

resource aws_sns_topic this {
  name         = "${var.budget_name}-notify-topic"
  display_name = "${var.budget_name}-notify-topic"
}

resource aws_sns_topic_policy this {
  arn    = aws_sns_topic.this.arn
  policy = data.aws_iam_policy_document.notify_sns_topic_policy.json
}

data aws_iam_policy_document notify_sns_topic_policy {
  policy_id = "__default_policy_ID"
  statement {
    sid    = "__default_statement_ID"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["budgets.amazonaws.com"]
    }
    actions = [
      "SNS:Publish",
    ]
    resources = ["${aws_sns_topic.this.arn}"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"
      values   = ["${data.aws_caller_identity.current.account_id}"]
    }
  }
}

data aws_caller_identity current {}
