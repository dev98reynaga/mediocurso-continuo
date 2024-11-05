resource "aws_instance" "mi_servidor" {
  ami           = "ami-xxxxxxxx" # Cambia a la AMI que necesitas
  instance_type = "t2.micro"
  tags = {
    Name = "${var.salon}-instance"
  }
}
