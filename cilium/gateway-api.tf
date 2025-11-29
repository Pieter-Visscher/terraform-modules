resource "kubernetes_manifest" "gateway_api_install" {
  manifest = yamldecode(data.http.gateway_api_manifest.response_body)
}
data "http" "gateway_api_manifest" {
  url = "https://github.com/kubernetes-sigs/gateway-api/releases/download/${var.gateway_api_version}/standard-install.yaml"
  response_body_allow_list = ["text/plain", "application/yaml", "text/yaml"]
  
  timeout = 30s
}

resource "kubernetes_manifest" "gateway_api_install" {
  manifest = yamldecode(data.http.gateway_api_manifest.response_body)
  server_side_apply = true
}
