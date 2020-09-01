# Select most recent image as the AMI to use
data "aws_ami" "bastion" {
  most_recent = true
  owners = ["099720109477"]
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "ena-support"
    values = ["true"]
  }
}

# Create EC2 instances
resource "aws_instance" "instance" {
  for_each = var.subnet_ids
  ami = data.aws_ami.bastion.id
  monitoring = true
  instance_type = var.instance_type
  vpc_security_group_ids = var.security_group_ids
  subnet_id = each.value
  iam_instance_profile = var.iam_instance_profile
  tags = {
    Name = var.instance_name
    Description = var.instance_description
  }
  lifecycle {
    ignore_changes = [
      key_name
    ]
  }
  provisioner "file" {
    content = var.authorized_keys
    destination = "/home/ubuntu/.ssh/authorized_keys"
  }
}

# Create elastic IPs
resource "aws_eip" "server_eip" {
  for_each = var.subnet_ids
  vpc = true
  tags = {
    Name = var.instance_name
  }
}

# Associate elastic IPs
resource "aws_eip_association" "server_eip_association" {
  for_each = var.subnet_ids
  public_ip = aws_eip.server_eip[each.key].public_ip
  instance_id = aws_instance.instance[each.key].id
}
