resource "routeros_ip_dhcp_server_option" "dhcp_options" {
  for_each = local.dhcp_options_map

  code      = each.value.code
  name      = each.value.name
  value     = each.value.value
}

resource "routeros_ip_dhcp_server_option_set" "dhcp_option_sets" {
  for_each  = local.dhcp_option_set_map

  name      = each.value.name
  options   = each.value.options

  depends_on  = [resource.routeros_ip_dhcp_server_option.dhcp_options]
}

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
  dhcp_option_set     = each.value.dhcp_options

  depends_on = [resource.routeros_ip_pool.pools, routeros_ip_dhcp_server_network.dhcp_server_network, resource.routeros_ip_dhcp_server_option.dhcp_options, routeros_ip_dhcp_server_option_set.dhcp_option_sets]
}

resource "routeros_ip_dhcp_server_network" "dhcp_server_network" {
  for_each =  {
    for v in local.vlan_map : v.name => v
    if v.dhcp
  }

  address     = each.value.dhcp_network
  gateway     = each.value.dhcp_gateway
  dns_server  = [each.value.dhcp_gateway]
  comment     = each.value.comment

  next_server = (
    contains(local.pxe_options_map, each.key)
      ? local.pxe_options_map[each.key].next_server
      : null
  )

  boot_file_name = (
    contains(local.pxe_options_map, each.key)
      ? try(local.pxe_options_map[each.key].bootfile, null)
      : null
  )
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
