resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = false

  values = [file("${path.module}/values/argocd.yaml")]

  depends_on = [kubernetes_secret.argocd_redis]

  timeout = 1200
}

resource "kubernetes_namespace" "this" {
  metadata {
    labels = {
      Terraform = true
    }

    name = "argocd"
  }
}

resource "kubernetes_secret" "argocd_redis" {
  metadata {
    name      = "argocd-redis"
    namespace = "argocd"
  }

  data = {
    auth = base64encode("your_redis_password")
  }

  depends_on = [kubernetes_namespace.this]
}

resource "kubernetes_config_map" "argocd-cm" {
  metadata {
    name      = "argocd-cm"
    namespace = "argocd"

    annotations = var.argocd-configmap.annotations
    labels      = var.argocd-configmap.labels
  }

  data       = var.argocd-configmap.data
  depends_on = [helm_release.argocd]
}

resource "kubernetes_config_map" "argocd-rbac-cm" {

  metadata {
    name      = "argocd-rbac-cm"
    namespace = "argocd"

    annotations = var.argocd-rbac.annotations
    labels      = var.argocd-rbac.labels
  }

  data       = var.argocd-rbac.data
  depends_on = [helm_release.argocd]
}
