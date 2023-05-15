provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_user" "example_user" {
  name = "dube"
}

resource "aws_iam_access_key" "example_access_key" {
  user = aws_iam_user.example_user.name
}

output "access_key" {
  value = aws_iam_access_key.example_access_key.id
}

output "secret_key" {
  value     = aws_iam_access_key.example_access_key.secret
  sensitive = true
}
