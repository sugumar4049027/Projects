provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_user" "example_user" {
  name = "dube"
}

resource "aws_iam_access_key" "example_access_key" {
  user = aws_iam_user.example_user.name
}

resource "aws_iam_group" "my_group" {
  name = "Ec2ReadonlyAccess"
}

resource "aws_iam_group_policy_attachment" "my_group_policy_attachment" {
  group      = aws_iam_group.my_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_user_group_membership" "my_user_group_membership" {
  user = aws_iam_user.example_user.name
  groups = [
    aws_iam_group.my_group.name,
  ]
}

output "access_key" {
  value = aws_iam_access_key.example_access_key.id
}

output "secret_key" {
  value     = aws_iam_access_key.example_access_key.secret
  sensitive = true
}
