resource "routeros_wifi_channel" "channels" {
  for_each = local.wifi_channel_map

  name              = each.value.name
  band              = each.value.band
  width             = each.value.channel_width
  skip_dfs_channels = each.value.skip_dfs
  reselect_interval = each.value.reselect_interval
  frequency         = each.value.frequency
}
