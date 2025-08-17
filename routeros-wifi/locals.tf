locals {
  wifi_config_full = [
    for wifi in var.wifi_config : merge(
      wifi,
      { password = lookup(var.wifi_passwords, wifi.name, null) }
    )
  ]
}
