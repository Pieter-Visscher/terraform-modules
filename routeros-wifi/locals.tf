locals {
  wifi_security_full = [
    for wifi in var.wifi_security: merge(
      wifi,
      { password = lookup(var.wifi_passwords, wifi.name, null) }
    )
  ]
}

locals {
  wifi_config24_map  = { for config in var.wifi_config-24ghz : config.name => config }
  wifi_config5_map  = { for config in var.wifi_config-5ghz : config.name => config }
  wifi_channel_map = { for channel in var.wifi_channel : channel.name => channel }
  wifi_datapath_map = { for datapath in var.wifi_datapath : datapath.name => datapath }
  wifi_security_map = { for security in local.wifi_security_full : security.name => security }
}
