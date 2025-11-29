data "http" "gateway_api_manifest" {
  url = "https://github.com/kubernetes-sigs/gateway-api/releases/download/${var.gateway_api_version}/standard-install.yaml"
}

locals {
  # Split the downloaded YAML into documents
  raw_docs = split("\n---", data.http.gateway_api_manifest.response_body)

  # Decode only valid documents
  decoded_docs = [
    for doc in local.raw_docs : yamldecode(doc)
    if trimspace(doc) != ""                               # skip empty
    && !startswith(trimspace(doc), "#")                   # skip comment-only
    && can(yamldecode(doc))                               # must decode
    && try(yamldecode(doc).kind, "") != ""                # must have kind
  ]

  # Remove status from CRDs (kubernetes_manifest forbids it)
  cleaned_docs = [
    for d in local.decoded_docs :
    (
      d.kind == "CustomResourceDefinition"
      ? merge(d, { status = null })
      : d
    )
  ]
}

resource "kubernetes_manifest" "gateway_api" {
  for_each = {
    for idx, doc in local.cleaned_docs :
    idx => doc
  }

  manifest = each.value
}

