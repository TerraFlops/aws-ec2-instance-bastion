variable "instance_name" {
  description = "Name of the EC2 bastion instance"
  type = string
  default = "Bastion"
}

variable "instance_description" {
  description = "Optional instance description"
  type = string
  default = null
}

variable "instance_type" {
  description = "Instance type, defaults to t3a.nano"
  type = string
  default = "t3a.nano"
}

variable "ami_id" {
  description = "Optional override for AMI ID, change with caution"
  type = string
  default = "ami-0f87b0a4eff45d9ce"
}

variable "authorized_keys" {
  description = "Authorized SSH keys file which will be injected into the Bastion server"
  type = string
  default = null
}

variable "iam_instance_profile" {
  description = "Optional IAM instance profile name"
  type = string
  default = null
}

variable "subnet_ids" {
  description = "Set of AWS subnet IDs into which bastions will be launched"
  type = set(string)
}

variable "security_group_ids" {
  description = "Set of AWS security group IDs which will be linked to the bastion"
  type = set(string)
  default = []
}