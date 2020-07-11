# output bill_alert_arn {
#   value       = module.bill_alert.this_aws_cloudwatch_metric_alarm_arn
#   description = "請求アラームのARN値"
# }

output cost_budget_id {
  value       = module.aws_cost_budgets.this_aws_budgets_budget_id
  description = "予算ID"
}
