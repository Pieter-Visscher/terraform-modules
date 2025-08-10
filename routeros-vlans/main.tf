resource "routeros_interface_vlan" "interface_vlan" {
  for_each = local.vlan_map

  interface = var.bridge
  name      = each.value.name
  vlan_id   = each.value.id
}
