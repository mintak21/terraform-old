# module bill_alert {
#   source = "./../module/aws/cloudWatch/alerm/estimatedCharges"

#   alarm_name     = "Total Usage"
#   namespace      = "AWS/Billing"
#   maximum_amount = 1.25
#   currency       = "USD"
#   email_address  = var.email_address
# }

module aws_cost_budgets {
  source                            = "./../module/aws/budget/cost"
  budget_limit_usd                  = 1.25
  budget_notification_email_address = var.email_address
}
