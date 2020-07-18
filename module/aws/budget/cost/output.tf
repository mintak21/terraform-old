output this_aws_budgets_budget_id {
  value       = aws_budgets_budget.this.id
  description = "作成した予算のID"
}

output this_aws_sns_topic_arn {
  value       = aws_sns_topic.this.arn
  description = "予算通知するSNSトピックのARN値"
}
