variable "default_cidr" {
  description = "Default cidr used as base for all subnets"
  type        = string
}

variable "dhcp_range" {
  description = "range used for DHCP server"
  type        = list(number)
}

variable "vlans" {
  description = "List of vlans present on your Mikrotik device"
  type = list(object({
    name           = string
    comment        = string
    interface      = string
    id             = number
    tagged_ports   = list(string)
    untagged_ports = list(string)
    dhcy           = bool
  }))
}
