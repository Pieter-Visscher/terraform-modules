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

  name            = each.value.name
  interface       = routeros_interface_wireguard.wireguard-interface.name
  public_key      = each.value.public_key
  private_key     = each.value.private_key
  preshared_key   = each.value.psk
  is_responder    = false
  allowed_address = each.value.subnets[0] == "omit" ? [
  "${split(".", cidrhost(var.default_cidr, 0))[0]}.${split(".", cidrhost(var.default_cidr, 0))[1]}.${var.vpn_interface_subnet}.${each.value.id}/32"
] : concat(
  each.value.subnets,
  [
    "${split(".", cidrhost(var.default_cidr, 0))[0]}.${split(".", cidrhost(var.default_cidr, 0))[1]}.${var.vpn_interface_subnet}.${each.value.id}/32"
  ]
)
  client_endpoint = var.wan_ip
  client_address  = "${split(".", cidrhost(var.default_cidr, 0))[0]}.${split(".", cidrhost(var.default_cidr, 0))[1]}.${var.vpn_interface_subnet}.${each.value.id}/24"
  comment         = each.value.comment

}


resource "routeros_ip_route" "wireguard_routes" {
  for_each      = {
    for vpn, peer in local.vpn_peers : vpn => peer
    if peer.subnets[0] != "omit"
  }

  dst_address = each.value.subnets[0]
  gateway = "${split(".", cidrhost(var.default_cidr, 0))[0]}.${split(".", cidrhost(var.default_cidr, 0))[1]}.${var.vpn_interface_subnet}.${each.value.id}"
}

resource "routeros_ip_firewall_filter" "allow-wireguard" {
  action            = "accept"
  chain             = "input"
  in_interface_list = "WAN"
  protocol          = "udp"
  dst_port          = "51820"
}
