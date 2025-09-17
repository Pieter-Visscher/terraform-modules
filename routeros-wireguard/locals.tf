locals {
  vpn_address = "${split(".", cidrhost(var.default_cidr, 0))[0]}.${split(".", cidrhost(var.default_cidr, 0))[1]}.${var.vpn_interface_subnet}.${var.vpn_inteface_address}/24"
}
