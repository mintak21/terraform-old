resource aws_cloudwatch_metric_alarm this {
  alarm_name        = "Billing Alert For ${var.alarm_name} ${var.currency}"
  alarm_description = "This alarm is issued when the continuous usage fee on AWS exceeds ${var.maximum_amount} ${var.currency}"

  # しきい値設定
  namespace = var.namespace
  dimensions = {
    Currency = "${var.currency}"
  }
  threshold           = var.maximum_amount
  comparison_operator = "GreaterThanThreshold"
  metric_name         = "EstimatedCharges"

  # 以下の制約あり
  ## Ref. 請求アラームを適切に動作させるには、「期間」を 6 時間に、「統計」を最大に設定し、アラームが 1 つの連続した期間でトリガーされるように設定してください。
  statistic          = "Maximum"
  evaluation_periods = 1
  period             = 6 * 60 * 60

  treat_missing_data = "missing"

  actions_enabled = "true"
  alarm_actions   = ["${aws_sns_topic.this.arn}"]
}

resource aws_sns_topic this {
  name         = "CloudWatch_Alarms_Topics_For_${var.alarm_name}"
  display_name = "CloudWatch_Alarms_Topics_For_${var.alarm_name}"
}

resource aws_sns_topic_policy this {
  arn    = aws_sns_topic.this.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource aws_sns_topic_subscription this {
  topic_arn = aws_sns_topic.this.arn
  # Eメールはコンソールからは指定可能だが、Terraformではサポートされていない
  protocol = "email"
  endpoint = var.email_address
}

data aws_iam_policy_document sns_topic_policy {
  # コンソールでCloudWatchのアクション設定で作成したときにできるデフォルトポリシーの設定
  policy_id = "__default_policy_ID"
  statement {
    sid    = "__default_statement_ID"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudwatch.amazonaws.com"]
    }
    actions = [
      "SNS:Subscribe",
      "SNS:Publish",
      "SNS:Receive",
    ]
    resources = ["${aws_sns_topic.this.arn}"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = ["${data.aws_caller_identity.current.account_id}"]
    }
  }
}

data aws_caller_identity current {}
