resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    gateway_id = var.internet_gateway_id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "rt-${var.vpc_name}/PublicRouteTable"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_ids)
  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    nat_gateway_id = var.nat_gateway_id
    cidr_block     = "0.0.0.0/0"
  }

  tags = {
    Name = "rt-${var.vpc_name}/PrivateRouteTable"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_ids)
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private.id
}
