
locals {
  # Helper to calculate network and address or each VLAN
  vlan_map = {
    for k, v in var.vlans : v.name => merge(v, {
      dhcp_gateway = "${split(".", cidrhost(var.default_cidr, 0))[0]}.${split(".", cidrhost(var.default_cidr, 0))[1]}.${v.id}.1"
      dhcp_network = "${split(".", cidrhost(var.default_cidr, 0))[0]}.${split(".", cidrhost(var.default_cidr, 0))[1]}.${v.id}.0/24"
      pool_start = "${split(".", cidrhost(var.default_cidr, 0))[0]}.${split(".", cidrhost(var.default_cidr, 0))[1]}.${v.id}.${var.dhcp_range[0]}"
      pool_end = "${split(".", cidrhost(var.default_cidr, 0))[0]}.${split(".", cidrhost(var.default_cidr, 0))[1]}.${v.id}.${var.dhcp_range[1]}"
    })
  }

  dhcp_options_map = { for options in var.dhcp_options : options.name => options }
  dhcp_option_set_map = { for sets in var.dhcp_option_set : sets.name => sets }
}


