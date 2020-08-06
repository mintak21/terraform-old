output this_aws_cloudwatch_metric_alarm_arn {
  value       = aws_cloudwatch_metric_alarm.this.arn
  description = "請求アラームのARN値"
}

output this_aws_sns_topic_arn {
  value       = aws_sns_topic.this.arn
  description = "トピックのARN値"
}
