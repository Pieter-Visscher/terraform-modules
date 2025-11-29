data "http" "gateway_api_manifest" {
  url = "https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.4.0/standard-install.yaml"
}

resource "kubernetes_manifest" "gateway_api_install" {
  manifest = yamldecode(data.http.gateway_api_manifest.response_body)
  
  server_side_apply = true
}
