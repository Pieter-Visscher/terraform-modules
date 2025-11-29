data "http" "gateway_api_manifest" {
  url = "https://github.com/kubernetes-sigs/gateway-api/releases/download/${var.gateway_api_version}/standard-install.yaml"
}

locals {
  raw_docs = split("\n---", data.http.gateway_api_manifest.response_body)

  decoded_docs = [
    yamldecode(doc)
    for doc in local.raw_docs
    if(trimspace(doc) != "")
    if !startswith(trimspace(doc), "#")
    if can(yamldecode(doc))
    if try(yamldecode(doc).kind, "") != ""
  ]

  cleaned_docs = [
    merge(
      doc,
      doc.kind == "CustomResourceDefinition" ?
        { status = null } :
        {}
    )
    for doc in local.decoded_docs
  ]
}

resource "kubernetes_manifest" "gateway_api" {
  for_each = {
    for idx, doc in local.cleaned_docs :
    idx => doc
  }

  manifest = each.value
}

