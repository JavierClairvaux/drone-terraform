variable "region" {
  default = "{% your-region %}"
}

variable "drone-ami" {
  default = "{% your-drone-ami %}"
}

variable "drone-instance" {
  default = "{% your-drone-instance-type %}"
}

variable "drone-key" {
  default = "{% your-instance-key %}"
}

variable "security-grp-name" {
  default = "{% your-security-group-name %}"
}

variable "securty-grp-description" {
  default = "{% your-security-group-description %}"
}

variable "instance_user" {
  default = "{% your-instance-user %}"
}
