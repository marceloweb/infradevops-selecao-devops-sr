terraform {
  backend "s3" {
    bucket         = "teste-gl-bucket-terraform-state"
    key            = "comments-api/dev/terraform.tfstate"
    region         = "us-east-1"                     
    encrypt        = true
  }
}