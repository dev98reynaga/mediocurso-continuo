provider "aws" {
  region = "us-east-1"  # Cambia a tu región preferida
}

# Configuración de la instancia EC2
resource "aws_instance" "mi_servidor" {
  ami           = "ami-0866a3c8686eaeeba" 
  instance_type = "t2.micro"
  tags = {
    Name = "${var.salon}-instance"
  }
}

# Configuración del bucket S3 para sitio web estático
resource "aws_s3_bucket" "static_site" {
  bucket = "my-unique-static-site-bucket-12345"  # Cambia a un nombre único

  website {
    index_document = "index.html"
  }

  acl = "public-read"
}

# Cargar el archivo index.html en el bucket S3
resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.static_site.bucket
  key    = "index.html"
  source = "index.html"  # Asegúrate de tener este archivo en el mismo directorio
  acl    = "public-read"
}

# Output para la URL del sitio web estático en S3
output "site_url" {
  value = aws_s3_bucket.static_site.website_endpoint
}
