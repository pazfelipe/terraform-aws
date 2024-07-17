resource "aws_iam_group" "this" {
  for_each = local.user_groups
  name     = each.value.name
  path     = each.value.path
}

resource "aws_iam_group_policy" "this" {
  for_each = local.user_groups
  name     = each.value.policy.name
  group    = aws_iam_group.this[each.key].name

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = each.value.policy.Statement
  })
}