resource "routeros_interface_vlan" "interface_vlan" {
  for_each = local.vlan_map

  interface = each.value.interface
  name      = each.value.name
  comment   = each.value.comment
  vlan_id   = each.value.id

  lifecycle {
    create_before_destroy = false
  }
}

resource "time_sleep" "wait_for_vlan" {
  depends_on = [resource.routeros_interface_vlan.interface_vlan]
  create_duration = "1s"
}
