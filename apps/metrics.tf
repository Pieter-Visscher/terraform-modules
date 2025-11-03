resource "kubernetes_manifest" "metrics-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace  = "argocd"
      name = "metrics"
    }
    spec = {
      project = "default"
      source = {
        repoURL = "git@github.com:Pieter-Visscher/kubernetes-argo.git"
        path = "metrics/"
        targetRevision = "HEAD"
        directory = {
          recurse = true
        }
      }
      destination = {
        server = "https://kubernetes.default.svc"
      }
      syncPolicy = {
        automated = {
          selfHeal = true
        }
        syncOptions = [
        ]
      }
    }
  }
}
