resource "routeros_wifi_capsman" "capsman" {
  enabled        = var.CAPsMAN
  upgrade_policy = "suggest-same-version"
  interfaces     = var.CAPsMAN_interfaces
}

resource "routeros_wifi_provisioning" "provisioning_24ghz" {
  action    = "create-dynamic-enabled"
  master_configuration = var.wifi_config-24ghz[0].name
  slave_configurations = [for config in slice(var.wifi_config, 1, length(var.wifi_config)) : config.name]
  }

resource "routeros_wifi_provisioning" "provisioning_5ghz" {
  action    = "create-dynamic-enabled"
  master_configuration = var.wifi_config-5ghz[0].name
  slave_configurations = [for config in slice(var.wifi_config, 1, length(var.wifi_config)) : config.name]
  }
