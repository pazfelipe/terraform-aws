locals {
  roles = {
    read_only = {
      metadata = {
        name      = "read-only-pods"
        namespace = "kube-system"
      }
      subjects = yamldecode(file("${path.module}/values/readonly-role-binding.yaml"))["subjects"]
      role_ref = yamldecode(file("${path.module}/values/readonly-role-binding.yaml"))["roleRef"]
      rules    = yamldecode(file("${path.module}/values/readonly-pod-role.yaml"))["rules"]
    }

    editor = {
      metadata = {
        name      = "editor"
        namespace = "kube-system"
      }

      subjects = yamldecode(file("${path.module}/values/editor-role-binding.yaml"))["subjects"]
      role_ref = yamldecode(file("${path.module}/values/editor-role-binding.yaml"))["roleRef"]
      rules    = yamldecode(file("${path.module}/values/editor-pod-role.yaml"))["rules"]
    }
  }

  aws_auth_configmap = yamldecode(file("${path.module}/values/aws-auth.yaml"))
}

locals {
  argocd = {
    configmap = {
      annotations = yamldecode(file("${path.module}/values/argocd-cm.yaml"))["metadata"]["annotations"]
      labels      = yamldecode(file("${path.module}/values/argocd-cm.yaml"))["metadata"]["labels"]
      data        = yamldecode(file("${path.module}/values/argocd-cm.yaml"))["data"]
    }

    rbac = {
      annotations = yamldecode(file("${path.module}/values/argocd-rbac-cm.yaml"))["metadata"]["annotations"]
      labels      = yamldecode(file("${path.module}/values/argocd-rbac-cm.yaml"))["metadata"]["labels"]
      data        = yamldecode(file("${path.module}/values/argocd-rbac-cm.yaml"))["data"]
    }
  }
}

locals {
  karpenter = {
    ttlSecondsAfterEmpty   = 60
    ttlSecondsUntilExpired = 604800
    limits = {
      resources = {
        cpu = 100
      }
    }
    requirements = [
      {
        key      = "karpenter.k8s.aws/instance-family"
        operator = "In"
        values   = ["a1", "t3"]
      },
      {
        key      = "karpenter.k8s.aws/instance-size"
        operator = "NotIn"
        values   = ["m5", "r5"]
      }
    ]
    subnetSelector = {
      key   = "kubernetes.io/cluster/${var.project_id}"
      value = "owned"
    }
    securityGroupSelector = {
      key   = "kubernetes.io/cluster/${var.project_id}"
      value = "owned"
    }
  }
}
