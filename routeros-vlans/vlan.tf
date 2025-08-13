resource "routeros_interface_vlan" "interface_vlan" {
  for_each = local.vlan_map

  interface = each.value.interface
  name      = each.value.name
  vlan_id   = each.value.id

  lifecycle {
    create_before_destroy = false
  }
}
