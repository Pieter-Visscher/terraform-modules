resource "routeros_ip_dhcp_client" "wan" {
  count = var.wan.dhcp == true ? 1 : 0

  add_default_route = yes
  interface         = var.wan.interface
  comment           = WAN
}
