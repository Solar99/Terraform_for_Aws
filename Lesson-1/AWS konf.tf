/*provider "aws" {
  access_key = "AKIA3WE3M3W2UANNBTFI"
  secret_key = "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"
  region     = "eu-central-1"
}*/
resource "aws_instance" "my_ubuntu" {
  ami           = "ami-0932440befd74cdba"
  instance_type = "t3.micro"
  tags = {
    Name    = "My ubuntu server"
    Owner   = "Andrey"
    Project = "Terraform Lessons"
  }
}
