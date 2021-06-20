# Create EC2 instances
resource "aws_instance" "instance" {
  ami = var.ami_id
  monitoring = true
  instance_type = var.instance_type
  vpc_security_group_ids = var.security_group_ids
  subnet_id = var.subnet_id
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
  user_data = templatefile("${path.module}/userdata.sh", {
    authorized_keys = var.authorized_keys
  })
}

# Create elastic IPs
resource "aws_eip" "server_eip" {
  vpc = true
  tags = {
    Name = var.instance_name
  }
}

# Associate elastic IPs
resource "aws_eip_association" "server_eip_association" {
  public_ip = aws_eip.server_eip.public_ip
  instance_id = aws_instance.instance.id
}

resource "aws_route53_record" "bastion" {
  name = var.route_53_cname
  type = "A"
  ttl = 60
  zone_id = var.route_53_zone_id
  allow_overwrite = true
  records = [
    aws_eip.server_eip.public_ip
  ]
}
