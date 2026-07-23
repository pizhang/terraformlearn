resource "aws_ssm_parameter" "test_param" {
  name  = "/associate004/foo"
  type  = "String"
  value = "bar"

  tags = {
    Name = "/associate004/foo"
  }
}

resource "aws_secretsmanager_secret" "test_secret" {
  name        = "/associate004/foo"
  description = "This is a test secret for associate004"
}