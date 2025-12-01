resource "helm_release" "longhorn" {
  name              = "longhorn"
  chart             = "longhorn"
  repository        = "https://charts.longhorn.io"
  version           = "${var.longhorn_version}"
  namespace         = "longhorn-system"
  create_namespace  = true
  timeout           = 600
  set_namespace_labels = {
    mgt-gateway-access = "true"
  }

  values = [yamlencode({
    defaultSettings = {
      defaultDataLocality = "best-effort"
      defaultReplicaCount = "2"
      defaultDataPath = "/var/mnt/sata"
      storageMinimalAvailablePercentage = "2"
    }
  })]
}
