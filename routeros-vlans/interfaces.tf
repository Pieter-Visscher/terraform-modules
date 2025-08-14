resource "routeros_interface_bridge_vlan" "bridge_vlan" {
  for_each = {
    for vlan_name, vlan_data in local.vlan_map :
    vlan_name => vlan_data
    if contains(keys(local.bridge_map), vlan_data.interface)
  }

  bridge  = each.value.interface
  vlan_ids = [each.value.id]
  tagged = concat(each.value.tagged_ports, each.value.interface)
  untagged = each.value.untagged_ports
}
