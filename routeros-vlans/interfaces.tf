resource "routeros_interface_bridge_vlan" "bridge_vlan" {
  for_each = local.vlan_map

  count = contains(keys(local.bridge_map), each.value.interface) ? 1 : 0

  bridge  = each.value.interface
  vlan_ids = [each.value.id]
  tagged = each.value.tagged_ports
  untagged = each.value.untagged_ports
}
