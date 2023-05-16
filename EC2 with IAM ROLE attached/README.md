```
provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_access_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.ec2_role.name
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "ec2_instance" {
  ami                  = "ami-0889a44b331db0194"
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "My EC2 Instance"
  }
}
```


####  ***Provider "aws":*** This declares the AWS provider and specifies the region that we want to use.

#### ***Resource "aws_iam_role" "ec2_role": *** This creates an IAM role named "ec2_role" using the aws_iam_role resource.
#### The assume_role_policy attribute defines the permissions that are required for an entity (in this case, an EC2 instance) to assume this role.

#### ***Resource "aws_iam_role_policy_attachment" "s3_access_policy":***
#### This attaches the AmazonS3ReadOnlyAccess policy to the IAM role named "ec2_role" using the aws_iam_role_policy_attachment resource. 
#### This policy grants read-only access to S3 buckets.

#### ***Resource "aws_iam_instance_profile" "ec2_instance_profile":***
#### This creates an instance profile named "ec2_instance_profile" using the aws_iam_instance_profile resource. 
#### We associate the "ec2_role" IAM role with this instance profile using the role attribute.

#### ***resource "aws_instance" "ec2_instance":*** 
#### This creates an EC2 instance using the aws_instance resource. 
#### We specify the Amazon Machine Image (AMI) and instance type using the ami and instance_type attributes, respectively. 
#### We also specify the name of the instance profile created earlier in the iam_instance_profile attribute, which causes the EC2 instance to assume
#### The IAM role associated with the instance profile and inherit its permissions.
#### Finally, we assign a name to the EC2 instance using the tags attribute.

#### The terraform.tfstate file is a JSON file that contains the current state of the infrastructure managed by Terraform. It records all the resources that 
#### Terraform has created, updated, or deleted. The state file is used by Terraform to plan and apply changes to the infrastructure. It's an important file that ####should be treated as a sensitive artifact, because it contains sensitive information such as credentials, secrets, and private IP addresses.

#### When you run terraform apply or terraform plan, Terraform generates a new state file based on the current configuration and the resources that have been created. This new state file reflects the current state of the infrastructure, and it's stored in the terraform.tfstate file in the same directory as your configuration file. Terraform reads this state file when you run subsequent commands, so it knows what resources it needs to create, update, or delete.

#### In addition to the terraform.tfstate file, Terraform also generates a terraform.tfstate.backup file. This backup file is a copy of the most recent state file, created before any changes are applied. Terraform creates this backup file as a precautionary measure, in case anything goes wrong during the apply process. If Terraform encounters an error during the apply process, it can use the backup file to restore the state to its previous state, helping to avoid any potentially catastrophic changes.

#### It's important to keep these state files safe and secure, because they contain sensitive information about your infrastructure. One way to do this is to store them in a version control system like Git, along with your Terraform configuration files. Alternatively, you can store them in a remote state store like AWS S3 or HashiCorp Consul. This way, you can share your infrastructure with others, track changes over time, and avoid losing your state files due to hardware failures or other disasters.



