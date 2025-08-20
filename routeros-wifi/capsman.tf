resource "routeros_wifi_capsman" "capsman" {
  enabled        = var.CAPsMAN
  upgrade_policy = "suggest-same-version"
  interfaces     = var.CAPsMAN_interfaces
}
