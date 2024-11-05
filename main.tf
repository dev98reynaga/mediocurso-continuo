provider "aws" {
  region = "us-east-1"  
}

# Configuración de la instancia EC2
resource "aws_instance" "mi_servidor" {
  ami           = "ami-0866a3c8686eaeeba" 
  instance_type = "t2.micro"
  tags = {
    Name = "${var.salon}-instance"
  }
}

# Configuración del bucket S3
resource "aws_s3_bucket" "static_site" {
  bucket = "my-unique-static-site-bucket-12345" 
}

# Configuración para habilitar el sitio web estático en el bucket
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = "index.html"
  }
}

# Cargar el archivo index.html en el bucket S3
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.static_site.bucket
  key    = "index.html"
  source = "index.html"  
}

# Output para la URL del sitio web estático en S3
output "site_url" {
  value = aws_s3_bucket.static_site.website_endpoint
}
