variable "provider_aws_access_key" {
  type     = string
  default  = ""
  nullable = false
}

variable "provider_aws_secret_key" {
  type     = string
  default  = ""
  nullable = false
}

variable "provider_aws_region" {
  type     = string
  default  = ""
  nullable = false
}

variable "docker_hub_credentials" {
  type     = object({
    username = string
    password = string
  })
  nullable = false
}