resource "helm_release" "longhorn" {
  name              = "longhorn"
  chart             = "longhorn"
  repository        = "https://charts.longhorn.io"
  version           = "${var.longhorn_version}"
  namespace         = "longhorn-system"
  create_namespace  = true
  timeout           = 600

  values = [yamlencode({
    defaultSettings = {
      storageNetwork = "kube-system/longhorn-macvlan"
      defaultDataLocality = "best-effort"
    }
  })]
}
