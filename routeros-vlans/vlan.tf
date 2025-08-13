resource "routeros_interface_vlan" "interface_vlan" {
  for_each = local.vlan_map

  interface = each.value.interface
  name      = each.value.name
  comment   = each.value.comment
  vlan_id   = each.value.id

  create_duration = "1s"
  lifecycle {
    create_before_destroy = false
  }
}
