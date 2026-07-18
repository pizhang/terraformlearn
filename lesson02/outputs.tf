# Output ARN of the SSM Parameter resource
output "ssm_parameter_arn" {
  value = aws_ssm_parameter.test_param.arn
}