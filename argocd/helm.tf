resource "helm_release" "argocd" {
  name              = "argocd"
  chart             = "argo-cd"
  repository        = "https://argoproj.github.io/argo-helm"
  version           = "${var.argocd_version}"
  namespace         = "argocd"
  create_namespace  = true
  timeout           = 600
}
