resource "kubernetes_manifest" "paperless-ngx-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace  = "argocd"
      name = "paperless-ngx"
    }
    spec = {
      project = "default"
      source = {
        repoURL = "git@github.com:Pieter-Visscher/kubernetes-argo.git"
        path = "paperless-ngx/"
        targetRevision = "HEAD"
        directory = {
          recurse = true
        }
      }
      destination = {
        namespace = "paperless-ngx"
        server = "https://kubernetes.default.svc"
      }
      syncPolicy = {
        automated = {
          selfHeal = true
        }
        syncOptions = [
          "CreateNamespace=true"
        ]
      }
    }
  }
}

#project: default
#source:
#  repoURL: git@github.com:Pieter-Visscher/kubernetes-argo.git
#  path: pieter.fish/
#  targetRevision: HEAD
#  directory:
#    recurse: true
#    jsonnet:
#      tlas:
#        - name: ''
#          value: ''
#destination:
#  server: https://kubernetes.default.svc
#  namespace: pieter-fish-website
#syncPolicy:
#  automated:
#    selfHeal: true
#  syncOptions:
#    - CreateNamespace=true
