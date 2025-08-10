locals {
  # Convert list to map keyed by VLAN name
  vlan_map = { for vlan in var.vlans : vlan.name => vlan }
}
