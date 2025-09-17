resource "routeros_interface_wireguard" "wireguard-interface" {
  name  = "wireguard"
  listen_port = 51820
}

resource "routeros_ip_address" "wireguard-interface-address" {
  address     = local.vpn_address
  interface   = routeros_interface_wireguard.wireguard-interface.name
  comment     = "wireguard"

  depends_on  = [resource.routeros_interface_wireguard.wireguard-interface]
}

resource "routeros_interface_wireguard_peer" "wireguard-peer" {
  for_each        = local.vpn_peers

  interface       = routeros_interface_wireguard.wireguard-interface.name
  public_key      = each.value.public_key
  allowed_address = flatten([
  each.value.subnets,
  [
    "${split(".", cidrhost(var.default_cidr, 0))[0]}."
    "${split(".", cidrhost(var.default_cidr, 0))[1]}."
    "${var.vpn_interface_subnet}."
    "${each.value.id}/32"
  ]
])

}

resource "routeros_ip_firewall_filter" "allow-wireguard" {
  action            = "accept"
  chain             = "input"
  in_interface_list = "WAN"
  protocol          = "udp"
  dst_port          = "51820"
}

