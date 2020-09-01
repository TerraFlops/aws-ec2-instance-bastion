# Terraflops Terraform Module
 
### EC2 Bastion instance

This module can be used to create an EC2 bastion server within the public subnet of a VPC. During startup a list of authorized keys will be injected into the SSH authorized_keys
file allowing access from authorized individuals. 

#### Example usage

```hcl-terraform
module "example" {
  source = "git::https://github.com/TerraFlops/aws-ec2-instance-bastion?ref=v1.0"
  instance_name = "Bastion"
  instance_bastion = "Example bastion server"
  instance_type = "t3a.nano"
  authorized_keys = file("./bastion/authorized_keys")
  iam_instance_profile = "BastionIamInstanceProfile"
  subnet_id = "subnet-xxxxxxxxxxxxxxxxxx"
  security_group_ids = [
    "sg-xxxxxxxxxxxxxxxxxx"
  ]
}
```
