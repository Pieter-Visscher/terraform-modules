data "http" "gateway_api_manifest" {
  url = "https://github.com/kubernetes-sigs/gateway-api/releases/download/${var.gateway_api_version}/standard-install.yaml"
}

locals {
  raw_docs = split("\n---", data.http.gateway_api_manifest.response_body)

  decoded_docs = [
    yamldecode(doc),
    for doc in local.raw_docs :
    doc
    if trimspace(doc) != ""                           # not empty
    && !startswith(trimspace(doc), "#")               # not comment-only
    && can(yamldecode(doc))                           # decodes to valid YAML
    && try(yamldecode(doc).kind, "") != ""            # has a Kubernetes kind
  ]

  cleaned_docs = [
    (
      doc.kind == "CustomResourceDefinition"
      ? merge(doc, { status = null })
      : doc
    ),
    for doc in local.decoded_docs : doc
  ]
}

resource "kubernetes_manifest" "gateway_api" {
  for_each = {
    for idx, doc in local.cleaned_docs :
    idx => doc
  }

  manifest = each.value
}
