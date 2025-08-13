resource "routeros_ip_address" "address" {
  for_each = local.vlan_map

  address   = each.value.address
  network   = each.value.network
  interface = each.value.name

  create_duration = "1s"
  depends_on = [resource.routeros_interface_vlan.interface_vlan]
}
