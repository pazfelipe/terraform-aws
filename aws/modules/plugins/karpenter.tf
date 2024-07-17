resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true

  name       = "karpenter"
  repository = "https://charts.karpenter.sh"
  chart      = "karpenter"
  version    = "v0.13.1"

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.karpenter_controller.arn
  }

  set {
    name  = "clusterName"
    value = var.cluster_id
  }

  set {
    name  = "clusterEndpoint"
    value = var.cluster_endpoint
  }

  set {
    name  = "aws.defaultInstanceProfile"
    value = aws_iam_instance_profile.karpenter.name
  }
}

resource "kubernetes_manifest" "karpenter_provisioner" {
  computed_fields = ["spec.requirements"]
  manifest = {
    apiVersion = "karpenter.sh/v1alpha5"
    kind       = "Provisioner"
    metadata = {
      name = "karpenter"
    }
    spec = {
      ttlSecondsAfterEmpty   = var.karpenter.ttlSecondsAfterEmpty
      ttlSecondsUntilExpired = var.karpenter.ttlSecondsUntilExpired
      limits                 = var.karpenter.limits
      requirements           = var.karpenter.requirements
      providerRef = {
        name = "karpenter-provider"
      }
    }
  }
  depends_on = [helm_release.karpenter]
}

resource "kubernetes_manifest" "karpenter_provider" {
  manifest = {
    apiVersion = "karpenter.k8s.aws/v1alpha1"
    kind       = "AWSNodeTemplate"
    metadata = {
      name = "karpenter-provider"
    }
    spec = {
      subnetSelector = {
        "${var.karpenter.subnetSelector.key}" = var.karpenter.subnetSelector.value
      }
      securityGroupSelector = {
        "${var.karpenter.securityGroupSelector.key}" = var.karpenter.securityGroupSelector.value
      }
    }
  }
  depends_on = [helm_release.karpenter]
}
