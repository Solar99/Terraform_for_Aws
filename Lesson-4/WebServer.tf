#-------------------------------------------
# My terraform
#
# Build WebServer during bootsrap
#
# Made by Andrey
#--------------------------------------------


provider "aws" {
  /*  access_key = ""
  secret_key = ""*/
  region = "eu-central-1"
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-0932440befd74cdba" #Ubuntu Linux AMI
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.My_webserver.id]
  user_data = templatefile("user_data.tpl", {
    f_name = "Andrey",
    l_name = "Pastushenko",
    names  = ["Vasya", "Kolya", "Petya", "John", "Donald", "Masha"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Andrey"
  }
}
resource "aws_security_group" "My_webserver" {
  name        = "Webserver Security Group"
  description = "My first SecurityGroup"


  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "0"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
