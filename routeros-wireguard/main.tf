resource "routeros_interface_wireguard" "wireguard-interface" {
  name  = "wireguard"
  listen_port = 51820
}

resource "routeros_ip_address" "wireguard-interface-address" {
  address = local.vpn_address
  interface = "wireguard"
  comment = "wireguard"
}
