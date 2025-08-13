resource "routeros_interface_bridge" "interface_bridge" {
  for_each        = local.bridge_map

  name            = each.value.name
  pvid            = each.value.pvid
  vlan_filtering  = true

  lifecycle {
    create_before_destroy = false
  }
}
