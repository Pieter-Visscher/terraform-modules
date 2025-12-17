data "http" "kubevirt_operator" {
  url = "https://github.com/kubevirt/kubevirt/releases/download/${var.kubevirt_operator_version}/kubevirt-operator.yaml"
}

data "kubectl_file_documents" "kubevirt_operator" {
  content = data.http.kubevirt_operator.response_body
  lifecycle {
    precondition {
      condition     = 200 == data.http.kubevirt_operator.status_code
      error_message = "Status code invalid"
    }
  }
}

resource "kubectl_manifest" "kubevirt_operator" {
  for_each  = data.kubectl_file_documents.kubevirt_operator.manifests
  yaml_body = each.value
}   

data "http" "kubevirt_cdi" {
  url = "https://github.com/kubevirt/containerized-data-importer/releases/download/${var.kubevirt_cdi_version}/cdi-operator.yaml"
}

data "kubectl_file_documents" "kubevirt_cdi" {
  content = data.http.kubevirt_cdi.response_body
  lifecycle {
    precondition {
      condition     = 200 == data.http.kubevirt_cdi.status_code
      error_message = "Status code invalid"
    }
  }
}

resource "kubectl_manifest" "kubevirt_cdi" {
  for_each  = data.kubectl_file_documents.kubevirt_cdi.manifests
  yaml_body = each.value
}   
