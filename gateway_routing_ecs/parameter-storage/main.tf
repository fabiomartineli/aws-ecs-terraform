resource "aws_ssm_parameter" "params" {
  count = length(var.params)

  name     = var.params[count.index].name
  type     = var.params[count.index].type
  value    = var.params[count.index].value
}
