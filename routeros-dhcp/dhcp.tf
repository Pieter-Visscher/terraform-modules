resource "routeros_ip_dhcp_server" "dhcp_server" {
  for_each =  {
    for v in local.vlan_map : v.name => v
    if v.dhcp
  }

  interface           = each.value.name
  address_pool        = "${each.value.name}-pool"
  name                = "${each.value.name}-dhcp-server"
  conflict_detection  = true
  comment             = each.value.comment

  depends_on = [resource.routeros_ip_pool.pools, routeros_ip_dhcp_server_network.dhcp_server_network]
}

resource "routeros_ip_dhcp_server_network" "dhcp_server_network" {d
  for_each =  {
    for v in local.vlan_map : v.name => v
    if v.dhcp
  }

  address     = each.value.dhcp_network
  gateway     = each.value.dhcp_gateway
  dns_server  = each.value.dhcp_gateway
  netmask     = "255.255.255.0"
  comment     = each.value.comment
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
