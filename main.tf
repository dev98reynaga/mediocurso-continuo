resource "aws_instance" "mi_servidor" {
  ami           = "ami-0866a3c8686eaeeba" 
  instance_type = "t2.micro"
  tags = {
    Name = "${var.salon}-instance"
  }
}
