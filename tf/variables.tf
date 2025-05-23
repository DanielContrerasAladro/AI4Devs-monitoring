variable "datadog_api_key" {
  description = "API Key de Datadog"
  type        = string
  sensitive   = true
}

variable "datadog_app_key" {
  description = "APP Key de Datadog"
  type        = string
  sensitive   = true
}

variable "aws_account_id" {
  description = "ID de la cuenta AWS para la integración con Datadog"
  type        = string
}
