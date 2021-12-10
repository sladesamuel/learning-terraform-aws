resource "aws_instance" "app_server" {
  ami           = "ami-0fc7c2761662b554f"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}

