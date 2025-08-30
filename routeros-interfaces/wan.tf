resource "routeros_ip_dhcp_client" "wan" {
  count = var.wan.dhcp == true ? 1 : 0

  add_default_route = "yes"
  interface         = var.wan.interface
  comment           = "WAN"
}

resource "routeros_interface_list" "wan" {
  name              = "WAN"
}

resource "routeros_interface_list_member" "wan" {
  depends_on        = [resource.routeros_interface_list.wan]

  interface         = var.wan.interface
  list              = "WAN"
}

resource "routeros_ip_firewall_nat" "wan_nat" {
  action              = "masquerade"
  chain               = "srcnat"
  out_interface_list  = "WAN"
}
