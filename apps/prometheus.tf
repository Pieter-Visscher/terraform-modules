#resource "kubernetes_manifest" "prometheus-argocd" {
#  manifest = {
#    apiVersion = "argoproj.io/v1alpha1"
#    kind       = "Application"
#    metadata = {
#      namespace  = "argocd"
#      name = "prometheus"
#    }
#    spec = {
#      project = "default"
#      source = {
#        repoURL = "git@github.com:Pieter-Visscher/kubernetes-argo.git"
#        path = "prometheus/"
#        targetRevision = "HEAD"
#        directory = {
#          recurse = true
#        }
#      }
#      destination = {
#        namespace = "prometheus"
#        server = "https://kubernetes.default.svc"
#      }
#      syncPolicy = {
#        automated = {
#          selfHeal = true
#        }
#        syncOptions = [
#          "CreateNamespace=true"
#        ]
#      }
#    }
#  }
#}
