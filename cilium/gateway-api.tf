data "http" "gateway_api_manifest" {
  url = "https://github.com/cert-manager/cert-manager/releases/download/v${var.cert_manager_version}/cert-manager.crds.yaml"
}

data "kubectl_file_documents" "gateway_api_manifest" {
  content = data.http.gateway_api_manifest.response_body
  lifecycle {
    precondition {
      condition     = 200 == data.http.cert_manager_crds.status_code
      error_message = "Status code invalid"
    }
  }
}

resource "kubernetes_manifest" "gateway_api_manifest" {
  for_each  = data.kubectl_file_documents.gateway_api_manifest
  yaml_body = each.value
}
