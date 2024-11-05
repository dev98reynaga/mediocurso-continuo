resource "aws_instance" "mi_servidor" {
  ami           = "ami-0866a3c8686eaeeba" 
  instance_type = "t2.micro"
  tags = {
    Name = "${var.salon}-instance"
  }
}

resource "aws_s3_bucket" "static_site" {
  bucket = "my-static-site-bucket"

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.static_site.bucket
  key    = "index.html"
  source = "index.html"  # Asegúrate de tener este archivo en el mismo directorio
  acl    = "public-read"
}

output "site_url" {
  value = aws_s3_bucket.static_site.website_endpoint
}
