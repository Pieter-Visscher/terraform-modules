resource "routeros_capsman_manager" "capsman_manager" {
  enabled        = var.CAPsMAN
  upgrade_policy = "suggest-same-version"
}
