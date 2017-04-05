provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.aws_region}"
}

resource "aws_security_group" "nexusSG" {
  name        = "Nexus-sg"
  description = "Used in the terraform"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




resource "aws_instance" "jenkins" {
  ami 				= "${lookup(var.aws_amis, var.aws_region)}"
  instance_type     = "t2.micro"
  security_groups   = ["${aws_security_group.nexusSG.name}"]
  user_data         = "${file("userdataNexus.sh")}"
  key_name 			= "devopsio"
  tags {
    Name            = "Jenkins"
  }
}

