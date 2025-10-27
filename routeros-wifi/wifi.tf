resource "routeros_wifi_channel" "channels" {
  for_each = local.wifi_channel_map

  name              = each.value.name
  band              = each.value.band
  width             = each.value.channel_width
  skip_dfs_channels = each.value.skip_dfs
  reselect_interval = each.value.reselect_interval
}

  #frequency         = each.value.frequency

resource "routeros_wifi_datapath" "datapaths" {
  for_each = local.wifi_datapath_map

  name                = each.value.name
  vlan_id             = each.value.vlan_id
  client_isolation    = each.value.client_isolation
  bridge              = each.value.bridge
  traffic_processing  = var.wifi_traffic_processing
}

resource "routeros_wifi_security" "security" {
  for_each = local.wifi_security_map

  name                  = each.value.name
  authentication_types  = each.value.authentication_types
  ft                    = each.value.ft
  ft_over_ds            = each.value.ft-over-ds
  management_protection = each.value.management_protection
  passphrase            = each.value.password
}

resource "routeros_wifi_configuration" "configurations_24ghz" {
  for_each = local.wifi_config24_map

  country = var.wifi_country

  name    = each.value.name
  ssid    = each.value.ssid

  antenna_gain = 3


  channel = {
    config = each.value.channel
  }

  datapath = {
    config = each.value.datapath
  }

  security = {
    config = each.value.security
  }

  depends_on = [
    resource.routeros_wifi_security.security,
    resource.routeros_wifi_datapath.datapaths,
    resource.routeros_wifi_channel.channels
  ]
}

resource "routeros_wifi_configuration" "configurations_5ghz" {
  for_each = local.wifi_config5_map

  country = var.wifi_country

  name    = each.value.name
  ssid    = each.value.ssid

  antenna_gain = 3


  channel = {
    config = each.value.channel
  }

  datapath = {
    config = each.value.datapath
  }

  security = {
    config = each.value.security
  }

  depends_on = [
    resource.routeros_wifi_security.security,
    resource.routeros_wifi_datapath.datapaths,
    resource.routeros_wifi_channel.channels
  ]
}
