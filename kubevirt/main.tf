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

data "http" "kubevirt_cdi_operator" {
  url = "https://github.com/kubevirt/containerized-data-importer/releases/download/${var.kubevirt_cdi_version}/cdi-operator.yaml"
}

data "kubectl_file_documents" "kubevirt_cdi_operator" {
  content = data.http.kubevirt_cdi_operator.response_body
  lifecycle {
    precondition {
      condition     = 200 == data.http.kubevirt_cdi_operator.status_code
      error_message = "Status code invalid"
    }
  }
}

resource "kubectl_manifest" "kubevirt_cdi_operator" {
  for_each  = data.kubectl_file_documents.kubevirt_cdi_operator.manifests
  yaml_body = each.value
}   

resource "kubernetes_manifest" "kubevirt" {
  manifest = {
    apiVersion = "kubevirt.io/v1"
    kind = "KubeVirt"
    metadata = {
      name = "kubevirt"
      namespace = "kubevirt"
    }
    spec = {
      configuration = {
        developerConfiguration = {
          featureGates = [
            "LiveMigration", "NetworkBindingPlugins"
          ]
        }
        smbios = {
          sku = "TalosCloud"
          version = "v0.1.0"
          manufacturer = "Talos Virtualization"
          product = "talosvm"
          family = "ccio"
        }
      }
      workloadUpdateStrategy = {
        workloadUpdateMethods = [
          "LiveMigrate"
        ]
      }
    }
  }
  depends_on = [resource.kubectl_manifest.kubevirt_operator]
}

resource "kubernetes_manifest" "kubevirt_cdi" {
  manifest = {
    apiVersion = "cdi.kubevirt.io/v1beta1"
    kind = "CDI"
    metadata = {
      name = "cdi"
    }
    spec = {
      config = {
        scratchSpaceStorageClass = "longhorn"
        podResourceRequirements = {
          requests = {
            cpu = "100m"
            memory = "60M"
          }
          limits = {
            cpu = "750m"
            memory = "2Gi"
         }
        }
      }
    }
  }
  depends_on = [resource.kubectl_manifest.kubevirt_cdi_operator]
  }
