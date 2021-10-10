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
  ami                    = "ami-02f9ea74050d6f812" #Amazon
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.My_webserver.id]
  user_data              = <<EOF
#!/bin/base
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2> WebServer with IP: $myip</h2><br>Build by Terraform!" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF
}
resource "aws_security_group" "My_webserver" {
  name        = "Webserver Security Group"
  description = "My first SecurityGroup"
  ingress {
    #  description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    #  description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}
