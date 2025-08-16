locals {
  # convert list to map keyed by bridge name
  bridge_map  = { for bridge in var.bridges : bridge.name => bridge }
}

locals {
  # Helper to calculate network and address or each VLAN
  vlan_map = {
    for k, v in var.vlans : v.name => merge(v, {
      network = "${split(".", cidrhost(var.default_cidr, 0))[0]}.${split(".", cidrhost(var.default_cidr, 0))[1]}.${v.id}.0"
      address = "${split(".", cidrhost(var.default_cidr, 0))[0]}.${split(".", cidrhost(var.default_cidr, 0))[1]}.${v.id}.1/24"
    })
  }
}

locals {
  untagged_pairs = flatten([
    for vlan in var.vlans : [
      for port in vlan.untagged_ports : {
        pvid          = vlan.id
        bridge        = vlan.interface
        comment       = vlan.comment
        untagged_port = port
      }
    ]
  ])
  tagged_pairs = flatten([
    for vlan in var.vlans : [
      for port in vlan.tagged_ports: {
        pvid          = 1
        bridge        = vlan.interface
        comment       = vlan.comment
        untagged_port = port
      }
    ]
  ])
  tagged_map = {
    for k, v in {
      for p in local.tagged_pairs : p.untagged_port => p...
    } : k => v[0]
  }

  untagged_map = {
    for k, v in {
      for p in local.untagged_pairs : p.untagged_port => p...
    } : k => v[0]
  }
  vlan_port_pairs = values(merge(local.tagged_map, local.untagged_map))
}
