resource "aws_ssm_parameter" "test_param" {
  name  = "/associate004/github"
  type  = "String"
  value = "bar"

  tags = {
    Name = "/associate004/github"
  }
}
