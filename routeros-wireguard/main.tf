resource "routeros_interface_wireguard" "wireguard-interface" {
  name  = "wireguard"
  listen_port = 51820
}
