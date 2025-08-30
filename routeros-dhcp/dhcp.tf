resource "routeros_ip_dhcp_server" "dhcp_server" {
  for_each = local.vlan_map

  interface     =  each.value.name
  address_pool  = "${each.value.name}-pool"
  name          = "${each.value.name}-dhcp-server"
  comment       = each.value.comment

  depends_on = [resource.routeros_ip_pool.pools]
}

resource "routeros_ip_pool" "pools" {
  for_each =  {
    for v in local.vlan_map : v.name => v
    if v.dhcp
  }

  comment       = each.value.comment
  name          = "${each.value.name}-pool"
  ranges        = ["${each.value.pool_start}-${each.value.pool_end}"]
}
