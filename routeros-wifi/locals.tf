locals {
  wifi_config_full = [
    for wifi in var.wifi_config : merge(
      wifi,
      { password = lookup(var.wifi_passwords, wifi.name, null) }
    )
  ]
}

locals {
  wifi_channel_map = { for channel in var.wifi_channel : channel.name => channel }
}
