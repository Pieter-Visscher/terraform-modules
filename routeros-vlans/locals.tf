locals {
  # Convert list to map keyed by VLAN name
  vlan_map    = { for vlan in var.vlans : vlan.name => vlan }

  # convert list to map keyed by bridge name
  bridge_map  = { for bridge in var.bridges : bridge.name => bridge }
}

