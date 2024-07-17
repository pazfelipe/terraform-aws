resource "aws_eip" "this" {
  domain = "vpc"
  tags = {
    Name = "${var.vpc_name}/NATIP"
  }
}

resource "aws_nat_gateway" "this" {
  subnet_id = var.public_subnet_id
  allocation_id = aws_eip.this.id

  tags = {
    Name = "${var.vpc_name}/NATGateway"
  }
}

resource "aws_route" "private_nat_gateway" {
  count                  = length(var.private_route_table_ids)
  route_table_id         = var.private_route_table_ids[count.index]
  destination_cidr_block = var.destination_cidr_block
  nat_gateway_id         = aws_nat_gateway.this.id
}