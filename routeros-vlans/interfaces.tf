resource "routeros_interface_bridge_vlan" "bridge_vlan" {
  for_each = {
    for vlan_name, vlan_data in local.vlan_map :
    vlan_name => vlan_data
    if contains(keys(local.bridge_map), vlan_data.interface)
  }

  bridge    = each.value.interface
  vlan_ids  = [each.value.id]
  tagged    = distinct(concat(each.value.tagged_ports, [each.value.interface]))
  #untagged  = each.value.untagged_ports
  comment   = each.value.comment
}

resource "routeros_interface_bridge_port" "bridge_port" {
  for_each = { for vlan, vlan_data in local.vlan_port_pairs :
  vlan.comment => vlan_data
  if contains(keys(local.bridge_map), vlan_data.bridge)
  }

  bridge    = each.value.bridge
  pvid      = each.value.pvid
  interface = each.value.untagged_port
  comment   = each.value.comment
}
