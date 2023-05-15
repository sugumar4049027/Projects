
main.tf 

With this code IAM USER example_user will be created with access and secret key

provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_user" "example_user" {
  name = "example_user"
}

resource "aws_iam_access_key" "example_access_key" {
  user = aws_iam_user.example_user.name
}

output "access_key" {
  value     = aws_iam_access_key.example_access_key.id
}

output "secret_key" {
  value     = aws_iam_access_key.example_access_key.secret
  sensitive = true
}



write this in terminal after applying terraform apply so both this file will be created.

terraform output -raw access_key > access_key.txt
terraform output -raw secret_key > secret_key.txt

