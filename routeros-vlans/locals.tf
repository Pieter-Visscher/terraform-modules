locals {
  # convert list to map keyed by bridge name
  bridge_map  = { for bridge in var.bridges : bridge.name => bridge }
}

locals {
  # Helper to calculate network and address or each VLAN
  vlan_map = {
    for k, v in var.vlans : v.name => merge(v, {
      address = "${split(".", cidrhost(var.default_cidr, 0))[0]}.${split(".", cidrhost(var.default_cidr, 0))[1]}.${v.id}.0"
      gateway = "${split(".", cidrhost(var.default_cidr, 0))[0]}.${split(".", cidrhost(var.default_cidr, 0))[1]}.${v.id}.1/24"
    })
  }
}

