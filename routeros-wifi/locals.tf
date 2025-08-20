locals {
  wifi_config_full = [
    for wifi in var.wifi_config : merge(
      wifi,
      { password = lookup(var.wifi_passwords, wifi.name, null) }
    )
  ]
}

locals {
  wifi_config_map  = { for config in local.wifi_config_full : config.name => config }
  wifi_channel_map = { for channel in var.wifi_channel : channel.name => channel }
  wifi_datapath_map = { for datapath in var.wifi_datapath : datapath.name => datapath }
  wifi_security_map = { for security in var.wifi_security : security.name => security }
}
