data "http" "gateway_api_manifest" {
  url = "https://github.com/kubernetes-sigs/gateway-api/releases/download/${var.gateway_api_version}/standard-install.yaml"
}

data "kubectl_file_documents" "gateway_api_manifest" {
  content = data.http.gateway_api_manifest.response_body
  lifecycle {
    precondition {
      condition     = data.http.gateway_api_manifest.status_code == 200
      error_message = "Failed to download Gateway API manifest"
    }
  }
}

resource "kubernetes_manifest" "gateway_api" {
  for_each = {
    for i, doc in data.kubectl_file_documents.gateway_api_manifest.documents :
    i => doc
  }

  manifest = yamldecode(each.value)
}
