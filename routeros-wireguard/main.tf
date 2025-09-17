resource "routeros_interface_wireguard" "wireguard-interface" {
  name  = "wireguard"
  listen_port = 51820
}

resource "routeros_ip_address" {
  address = var.vpn_interface_address
  interface = "wireguard"
}
