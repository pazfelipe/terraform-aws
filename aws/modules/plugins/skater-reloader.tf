resource "helm_release" "reloader" {
  name             = "reloader"
  repository       = "https://stakater.github.io/stakater-charts"
  chart            = "reloader"
  namespace        = "reloader"
  create_namespace = true
}

resource "kubernetes_cluster_role_binding" "reloader" {
  metadata {
    name = "reloader-cluster-role-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "reloader-role"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "reloader"
    namespace = "reloader"

  }

  depends_on = [helm_release.reloader]
}

resource "kubernetes_role" "reloader" {

  metadata {
    name      = "reloader-role"
    namespace = "reloader"
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps", "secrets", "pods"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "statefulsets", "daemonsets"]
    verbs      = ["get", "list", "watch", "patch"]
  }
  depends_on = [helm_release.reloader]
}
