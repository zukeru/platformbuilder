variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-west-2"
}

variable "access_key" {
  description = "The AWS acess key."
  default     = "${aws_access_key}"
}

variable "secret_key" {
  description = "The AWS secret."
  default     = "${aws_secret_key}"
}

variable "aws_amis" {
  default = {
    "us-west-2" = "ami-f173cc91"
  }
}

variable "availability_zones" {
  default     = "us-west-2a,us-west-2b"
  description = "List of availability zones, use AWS CLI to find your "
}

variable "key_name" {
  description = "Name of AWS key pair"
  default = "devopsio"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}
