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
resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-0932440befd74cdba" #Ubuntu Linux AMI
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.tpl", {
    f_name = "Andrey",
    l_name = "Pastushenko",
    names  = ["Vasya", "Kolya", "Petya", "John", "Donald", "Masha", "222"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Andrey"
  }
  lifecycle {
    create_before_destroy = true
  }

}
resource "aws_security_group" "my_webserver" {
  name        = "Webserver Security Group"
  description = "My First SecurityGroup"


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
