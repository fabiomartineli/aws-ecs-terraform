variable "vpc_id" {
  type     = string
  default  = ""
  nullable = false
}

variable "subnet_id_pub_1" {
  type     = string
  default  = ""
  nullable = false
}

variable "subnet_id_pub_2" {
  type     = string
  default  = ""
  nullable = false
}

variable "security_group_pub_id" {
  type     = string
  default  = ""
  nullable = false
}

variable "subnet_id_pri_1" {
  type     = string
  default  = ""
  nullable = false
}

variable "subnet_id_pri_2" {
  type     = string
  default  = ""
  nullable = false
}

variable "security_group_pri_id" {
  type     = string
  default  = ""
  nullable = false
}

variable "provider_aws_access_key" {
  type     = string
  nullable = false
}

variable "provider_aws_secret_key" {
  type     = string
  nullable = false
}

variable "provider_aws_region" {
  type     = string
  nullable = false
}


variable "docker_hub_credentials" {
  type     = object({
    username = string
    password = string
  })
  nullable = false
}