resource random_string suffix {
  length  = 6
  lower   = true
  number  = true
  special = false
}

resource aws_lambda_function this {
  runtime          = "go1.x"
  memory_size      = var.memory
  timeout          = 30
  function_name    = "${var.name}-${random_string.suffix.result}"
  description      = "${var.name} : ${var.handler}"
  handler          = var.handler
  filename         = var.archive_file
  role             = aws_iam_role.lambda_role.arn
  source_code_hash = filebase64sha256("${var.archive_file}")
  #source_code_hash = var.archive_file.output_base64sha256

  environment {
    variables = {
      NOTIFICATION_CHANNEL = var.slack_channel
    }
  }
}

// SNSサブスクリプション & トリガー
resource aws_sns_topic_subscription this {
  count = var.sns_trigger_enabled && length(var.sns_topic_arn) > 0 ? 1 : 0

  topic_arn = var.sns_topic_arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.this.arn
}

resource aws_lambda_permission default {
  count = var.sns_trigger_enabled && length(var.sns_topic_arn) > 0 ? 1 : 0

  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = var.sns_topic_arn
}

// Role / Policy
resource aws_iam_role lambda_role {
  name               = "RoleForAWSLambda${var.name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource aws_iam_policy lambda_logging {
  name        = "PolicyForAWSLambda${var.name}"
  description = "IAM policy for logging from a lambda"
  policy      = data.aws_iam_policy_document.logging_policy.json
}

resource aws_iam_role_policy_attachment logging {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource aws_iam_role_policy_attachment ssm_read {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

data aws_iam_policy_document logging_policy {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

data aws_iam_policy_document assume_role_policy {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    effect = "Allow"
  }
}

data aws_caller_identity current {}
