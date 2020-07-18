# module bill_alert {
#   source = "./../module/aws/cloudWatch/alerm/estimatedCharges"

#   alarm_name     = "Total Usage"
#   namespace      = "AWS/Billing"
#   maximum_amount = 1.25
#   currency       = "USD"
#   email_address  = var.email_address
# }

data archive_file func_zip {
  type        = "zip"
  source_file = var.lambda_file
  output_path = "${var.lambda_file}.zip"
}

module aws_cost_budgets {
  source                            = "./../module/aws/budget/cost"
  budget_limit_usd                  = 1.25
  budget_notification_email_address = var.email_address
}

module notifier {
  source              = "./../module/aws/lambda/go"
  name                = "budget-alert-to-slack"
  handler             = "notifier"
  archive_file        = data.archive_file.func_zip.output_path
  sns_trigger_enabled = true
  sns_topic_arn       = module.aws_cost_budgets.this_aws_sns_topic_arn
  slack_channel       = var.slack_notification_channel

  #depends_on = [data.archive_file.func_zip]
}

resource aws_ssm_parameter slack_token {
  name        = "alert_notify_slack_token"
  description = "Token For Use Slack API"
  type        = "SecureString"
  value       = var.slack_token

  tags = {
    parameter_type = "token"
  }
}
