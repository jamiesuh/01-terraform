variable "server_port" {
  type    = number
  default = 8080
}

variable "security_group_name" {
  type    = string
  default = "aws13-terraform-example-instance"
}
