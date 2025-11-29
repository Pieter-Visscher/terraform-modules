data "http" "gateway_api_manifest" {
  url = "https://github.com/kubernetes-sigs/gateway-api/releases/download/${var.gateway_api_version}/standard-install.yaml"
  lifecycle {
    precondition {
      condition     = length(self.response_body) > 0
      error_message = "Failed to fetch the Gateway API manifest from the URL."
    }
  }
}

resource "kubernetes_manifest" "gateway_api_install" {
  manifest = yamldecode(data.http.gateway_api_manifest.response_body)
  
  server_side_apply = true
}
