resource "aws_subnet" "public" {
  count  = length(var.zones)
  vpc_id = var.vpc_id
  cidr_block              = var.public_cidr_block
  map_public_ip_on_launch = true

  availability_zone = var.zones[count.index]

  tags = merge(var.public_tags, {
    Type = "public",
    Name = "subnet-public-${var.vpc_name}-${replace(substr(var.zones[count.index], 7, 3), "-", "")}"
  })
}

resource "aws_subnet" "private" {
  count  = length(var.zones)
  vpc_id = var.vpc_id
  cidr_block = var.private_cidr_block

  availability_zone = var.zones[count.index]

  tags = merge(var.private_tags, {
    Type = "private",
    Name = "subnet-private-${var.vpc_name}-${replace(substr(var.zones[count.index], 7, 3), "-", "")}"
  })
}
