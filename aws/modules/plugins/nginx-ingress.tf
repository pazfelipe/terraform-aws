resource "helm_release" "nginx-ingress" {
  name             = "nginx-ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.7.1"
  namespace        = "nginx-ingress"
  create_namespace = true

  set {
    name  = "controller.metrics.enabled"
    value = "true"
  }

  set {
    name = "service.annotations.service.beta.kubernetes.io/aws-load-balancer-type"
    value = "nlb"
  }
}
