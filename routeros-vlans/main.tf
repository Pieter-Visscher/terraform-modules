resource "routeros_interface_vlan" "interface_vlan" {
  for_each = var.vlans

  interface = "bridge"
  name      = each.value.name
  vlan_id   = each.value.id
}
