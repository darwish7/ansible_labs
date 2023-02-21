variable "vpc_id" {
  type = string
}
variable "sg_name" {
  type        = string
  default     = "terraform_http"
}

variable "sg_description" {
  type        = string
  default     = "allowing http from nlp"
}
variable "source-cidr-blocks" {
  type = string
  default = "0.0.0.0/0"
}
variable "source-cidr-blocks-ipv6" {
  type = string
  default = "::/0"
}

variable "instance_type" {
  type = string
}


variable "private_ec2_name" {
  type = string
}

variable "subnet_ids" {
  type = list
}