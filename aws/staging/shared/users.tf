resource "aws_iam_user" "this" {
  for_each      = local.users
  name          = each.value.username
  force_destroy = true

  path = each.value.path

  tags = merge(each.value.tags, { Terraform = true })
}

resource "aws_iam_access_key" "this" {
  for_each = local.users_with_access_key
  user     = aws_iam_user.this[each.key].name
}

resource "aws_iam_user_group_membership" "this" {
  for_each = local.users
  user     = aws_iam_user.this[each.key].name
  groups   = each.value.user_groups
}

resource "aws_iam_user_login_profile" "this" {
  for_each                = { for k, v in local.users : k => v if v.console == true }
  user                    = aws_iam_user.this[each.key].name
  password_reset_required = try(each.value.password_reset_required, false)

  lifecycle {
    ignore_changes = [password_reset_required]

  }
}

output "user_password" {
  value = {
    for user in keys(local.users) : user => aws_iam_user_login_profile.this[user].encrypted_password
    if local.users[user].console == true
  }
}
