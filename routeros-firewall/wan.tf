resource "routeros_interface_list" "wan_access" {
  name  = "wan_access"
}

resource "routeros_interface_list_member" "wan_access" {
  for_each = toset(var.wan_allowed)

  interface = each.value
  list      = routeros_interface_list.wan_access.name

  depends_on = [resource.routeros_interface_list.wan_access]
}

resource "routeros_ip_firewall" "wan_access" {
  action  = "accept"
  chain   = "forward"
  out_interface_list = "WAN"
  in_interface_list  = resource.routeros_interface_list.wan_access.name
  place_before  = 10
}
