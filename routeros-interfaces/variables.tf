variable "vlans" {
  description = "List of vlans present on your Mikrotik device"
  type = list(object({
    name           = string
    comment        = string
    interface      = string
    id             = number
    tagged_ports   = list(string)
    untagged_ports = list(string)
  }))
}

variable "vlan_address_creation" {
  description = "Automatically create addresses for a vlan"
  type = bool
  default = true
}

variable "bridges" {
  description = "List of vlans present on your Mikrotik device"
  type = list(object({
    name           = string
    pvid           = number
  }))
}

variable "default_cidr" {
  description = "Default cidr used as base for all subnets"
  type        = string
}

variable "wan" {
  description = "Configure interface as WAN port"
  type = object({
    interface   = string
    dhcp        = bool
  })
}

