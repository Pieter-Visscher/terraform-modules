
locals {
  # Helper to calculate network and address or each VLAN
  vlan_map = {
    for k, v in var.vlans : v.name => merge(v, {
      pool_start = "${split(".", cidrhost(var.default_cidr, 0))[0]}.${split(".", cidrhost(var.default_cidr, 0))[1]}.${v.id}.${var.dhcp_range[0]}"
      pool_end = "${split(".", cidrhost(var.default_cidr, 0))[0]}.${split(".", cidrhost(var.default_cidr, 0))[1]}.${v.id}.${var.dhcp_range[1]}"
    })
  }
}
