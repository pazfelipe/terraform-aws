output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.this.id
}

output "nat_eip_id" {
  description = "The ID of the EIP associated with the NAT Gateway"
  value       = aws_eip.this.id
}
