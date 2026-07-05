resource "aws_ssm_parameter" "test_param" {
    name = "foo"
    type = "String"
    value = "bar"
}