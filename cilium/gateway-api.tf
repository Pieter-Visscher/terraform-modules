data "http" "gateway_api_manifest" {
  url = "https://github.com/kubernetes-sigs/gateway-api/releases/download/${var.gateway_api_version}/standard-install.yaml"
}

locals {
  raw_docs = split("\n---", data.http.gateway_api_manifest.response_body)

  gateway_docs = [
    for doc in local.raw_docs :
    trimspace(doc)
    if trimspace(doc) != ""
  ]
}

resource "kubernetes_manifest" "gateway_api" {
  for_each = {
    for idx, doc in local.gateway_docs :
    idx => doc
  }

  manifest = yamldecode(each.value)
}
