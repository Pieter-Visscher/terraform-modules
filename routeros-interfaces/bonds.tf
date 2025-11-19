resource "routeros_interface_bonding" "interface_bonding" {
  for_each = local.bonds_map

  name      = each.value.name
  comment   = each.value.comment
  slaves    = each.value.slaves
  lacp_rate = each.value.lacp_rate
  mode      = each.value.mode
}
