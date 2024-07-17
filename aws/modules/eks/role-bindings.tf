resource "kubernetes_role_binding" "this" {
  for_each = var.roles
  metadata {
    name      = var.roles[each.key].metadata.name
    namespace = var.roles[each.key].metadata.namespace
  }

  role_ref {
    kind      = var.roles[each.key].role_ref.kind
    name      = var.roles[each.key].role_ref.name
    api_group = var.roles[each.key].role_ref.apiGroup
  }

  dynamic "subject" {
    for_each = var.roles[each.key].subjects
    content {
      kind      = subject.value.kind
      name      = subject.value.name
      api_group = subject.value.apiGroup
    }

  }
}

resource "kubernetes_role" "this" {
  for_each = var.roles

  metadata {
    name      = var.roles[each.key].role_ref.name
    namespace = var.roles[each.key].metadata.namespace
  }

  dynamic "rule" {
    for_each = var.roles[each.key].rules
    content {
      api_groups = rule.value.apiGroups
      resources  = rule.value.resources
      verbs      = rule.value.verbs
    }

  }
}