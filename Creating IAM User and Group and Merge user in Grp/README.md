***Creating IAM USER with ACCESS and SECRET KEYS and place them in a GROUP***
```
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
```
**write this in terminal after applying terraform apply so both this file will be created.**
```
terraform output -raw access_key > access_key.txt
terraform output -raw secret_key > secret_key.txt
```

![image](https://github.com/sugumar4049027/Projects/assets/43288759/03a87814-5abb-48fd-996c-86529d07d235)


![image](https://github.com/sugumar4049027/Projects/assets/43288759/ed7762e9-2d77-467c-af0a-33dfebc5fc96)


![image](https://github.com/sugumar4049027/Projects/assets/43288759/e6ec04a1-c3a4-40bd-aa0b-48e5bbadfa7d)


![image](https://github.com/sugumar4049027/Projects/assets/43288759/2d3aad42-b97e-4190-bef8-ab2da417ed11)


![image](https://github.com/sugumar4049027/Projects/assets/43288759/ac81408e-e156-4b02-9e28-8f337f15d439)


