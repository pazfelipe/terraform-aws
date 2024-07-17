variable "cluster_endpoint" {
  type        = string
  description = "Cluster endpoint"
}

variable "cluster_certificate" {
  type        = string
  description = "Cluster certificate"
}

variable "cluster_id" {
  type        = string
  description = "Cluster ID"
}

variable "region" {
  type        = string
  description = "Region"
}

variable "cluster_token" {
  type        = string
  description = "Cluster token"
}

variable "oicd_issuer" {
  description = "The URL of the OpenID Connect issuer"
  type        = string
  default     = "https://oidc.eks.us-east-1.amazonaws.com/id/EXAMPLED539D4633E53DE1B716D3041E"
}

variable "cluster_certificate_authority" {
  description = "value of certificate_authority_data"
  type        = string
}

variable "nodes_name" {
  description = "The name of the EKS nodes"
  type        = string
  default     = "nodes"
}

variable "roles" {
  description = "Kubernetes roles"
  type = map(object({
    metadata = object({
      name      = string
      namespace = string
    })
    role_ref = object({
      kind     = string
      name     = string
      apiGroup = string
    })
    subjects = list(object({
      kind     = string
      name     = string
      apiGroup = string
    }))
    rules = list(object({
      apiGroups = list(string)
      resources = list(string)
      verbs     = list(string)
    }))
  }))
}

variable "argocd-configmap" {
  description = "ArgoCD ConfigMaps"
  type = object({
    annotations = map(string)
    labels      = map(string)
    data        = map(string)
  })
}
variable "argocd-rbac" {
  description = "ArgoCD RBAC ConfigMaps"
  type = object({
    annotations = map(string)
    labels      = map(string)
    data        = map(string)
  })
}

variable "karpenter" {
  description = "Karpenter Provisioner and Provider configuration"
  type = object({
    ttlSecondsAfterEmpty   = number
    ttlSecondsUntilExpired = number
    limits = object({
      resources = object({
        cpu = number
      })
    })
    requirements = list(object({
      key      = string
      operator = string
      values   = list(string)
    }))
    subnetSelector = object({
      key   = string
      value = string
    })
    securityGroupSelector = object({
      key   = string
      value = string
    })
  })
}
