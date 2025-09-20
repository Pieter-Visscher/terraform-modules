resource "routeros_wifi_capsman" "capsman" {
  enabled        = var.CAPsMAN
  upgrade_policy = "suggest-same-version"
  interfaces     = var.CAPsMAN_interfaces
}

resource "routeros_wifi_provisioning" "provisioning_24ghz" {
  action    = "create-dynamic-enabled"
  supported_bands = distinct([for ch in var.wifi_channel : ch.band if contains([for cfg in var.wifi_config-24ghz : cfg.channel], ch.name)])
  master_configuration = var.wifi_config-24ghz[0].name
  slave_configurations = [for config in slice(var.wifi_config-24ghz, 1, length(var.wifi_config-24ghz)) : config.name]
  }

resource "routeros_wifi_provisioning" "provisioning_5ghz" {
  action    = "create-dynamic-enabled"
  supported_bands = distinct([for ch in var.wifi_channel : ch.band if contains([for cfg in var.wifi_config-5ghz : cfg.channel], ch.name)])
  master_configuration = var.wifi_config-5ghz[0].name
  slave_configurations = [for config in slice(var.wifi_config-5ghz, 1, length(var.wifi_config-5ghz)) : config.name]
  }
