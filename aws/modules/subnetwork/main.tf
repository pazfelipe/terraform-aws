resource "aws_subnet" "public" {
  count  = length(var.zones)
  vpc_id = var.vpc_id
  cidr_block              = var.public_cidr_block
  map_public_ip_on_launch = true

  availability_zone = var.zones[count.index]

  tags = var.public_tags
}

resource "aws_subnet" "private" {
  count  = length(var.zones)
  vpc_id = var.vpc_id
  cidr_block = var.private_cidr_block

  availability_zone = var.zones[count.index]

  tags = var.private_tags
}
