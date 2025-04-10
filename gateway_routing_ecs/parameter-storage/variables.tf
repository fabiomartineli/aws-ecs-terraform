variable "params" {
  type = list(object({
    name = string
    value = string
    type = string
  }))
  nullable = false
}