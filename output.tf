output "instance_id" {
  value = aws_instance.instance.id
}

output "public_dns" {
  value = aws_instance.instance.public_dns
}

output "public_ip" {
  value = aws_eip.server_eip.public_ip
}

output "private_ip" {
  value = aws_instance.instance.private_ip
}

output "private_dns" {
  value = aws_instance.instance.private_dns
}

output "eip_allocation_id" {
  value = aws_eip.server_eip.allocation_id
}

output "eip_association_id" {
  value = aws_eip.server_eip.association_id
}