#resource "kubernetes_manifest" "super-productivity-argocd" {
#  manifest = {
#    apiVersion = "argoproj.io/v1alpha1"
#    kind       = "Application"
#    metadata = {
#      namespace  = "argocd"
#      name = "super-productivity"
#    }
#    spec = {
#      project = "default"
#      source = {
#        repoURL = "git@github.com:Pieter-Visscher/kubernetes-argo.git"
#        path = "super-productivity/"
#        targetRevision = "HEAD"
#        directory = {
#          recurse = true
#        }
#      }
#      destination = {
#        namespace = "super-productivity"
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
