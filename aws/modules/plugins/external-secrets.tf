resource "helm_release" "external-secrets" {
  name             = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  version          = "0.9.1"
  namespace        = "external-secrets"
  create_namespace = true
}

resource "kubernetes_manifest" "this" {
  manifest = {
    apiVersion = "external-secrets.io/v1beta1"
    kind       = "SecretStore"
    metadata = {
      name      = "secretstore-agent"
      namespace = "default"
    }

    spec = {
      provider = {
        aws = {
          service = "SecretsManager"
          region  = var.region
          auth = {
            secretRef = {
              accessKeyIDSecretRef = {
                name = "awssm-secret"
                key  = "access-key"
              }
              secretAccessKeySecretRef = {
                name = "awssm-secret"
                key  = "secret-access-key"
              }
            }
          }
        }
      }
    }
  }
  depends_on = [helm_release.external-secrets]
}
