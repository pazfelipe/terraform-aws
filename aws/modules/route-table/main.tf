resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr_block
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = "${var.vpc_name}/PublicRouteTable"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_ids)
  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  count  = length(var.private_subnet_ids)
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.vpc_name}/PrivateRouteTable${upper(replace(var.zones[count.index], "-", ""))}"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_ids)
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = var.private_route_table_ids[count.index]
}
