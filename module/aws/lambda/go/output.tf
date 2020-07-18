output this_aws_lambda_function_arn {
  value       = aws_lambda_function.this.arn
  description = "作成したLambdaのARN値"
}

output this_aws_lambda_function_version {
  value       = aws_lambda_function.this.version
  description = "作成したLambdaの最新バージョン"
}

output this_aws_lambda_function_last_modified {
  value       = aws_lambda_function.this.last_modified
  description = "作成したLambdaの最終更新日時"
}
