resource "aws_iam_role" "datadog_integration" {
  name = "DatadogAWSIntegrationRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "datadog.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "datadog_policy" {
  name        = "DatadogAWSIntegrationPolicy"
  description = "Permisos mínimos para integración Datadog-AWS"
  policy      = file("${path.module}/scripts/datadog_policy.json")
}

resource "aws_iam_role_policy_attachment" "datadog_attach" {
  role       = aws_iam_role.datadog_integration.name
  policy_arn = aws_iam_policy.datadog_policy.arn
}

resource "datadog_integration_aws" "main" {
  account_id = var.aws_account_id
  role_name  = aws_iam_role.datadog_integration.name
  filter_tags = ["project:AI4Devs-monitoring"]
  host_tags   = ["env:prod"]
}