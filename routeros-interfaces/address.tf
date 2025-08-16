resource "routeros_ip_address" "address" {
  for_each = local.vlan_map

  address   = each.value.address
  network   = each.value.network
  interface = each.value.name
  comment   = each.value.comment

  depends_on = [resource.time_sleep.wait_for_vlan]
}
