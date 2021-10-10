#-------------------------------------------
# My terraform
#
# Build WebServer during bootsrap
#
# Made by Andrey
#--------------------------------------------


provider "aws" {

  region = "eu-central-1"
}


resource "aws_security_group" "My_webserver" {
  name = "Dynamic Security Group"


  dynamic "ingress" {
    for_each = ["80", "443", "8880", "1541", "9892"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "0"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name  = "DynamicSecurityGroup"
    owner = "Andrey"
  }
}
