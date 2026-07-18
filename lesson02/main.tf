resource "aws_ssm_parameter" "test_param" {
  name  = "/gibhub/workflow/test"
  type  = "String"
  value = "bar"

  tags = {
    Name = "/github/workflow/test"
  }
}
