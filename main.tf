# Create EC2 instances
resource "aws_instance" "instance" {
  for_each = var.subnet_ids
  ami = var.ami_id
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
      # Ignore any changes to the AMI image
      ami,
      # Ignore any changes to the EC2 key name
      key_name
    ]
  }
  user_data = templatefile("./userdata.sh", {
    authorized_keys = var.authorized_keys
  })
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
