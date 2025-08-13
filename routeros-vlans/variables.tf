variable "vlans" {
  description = "List of vlans present on your Mikrotik device"
  type = list(object({
    name           = string
    interface      = string
    id             = number
    tagged_ports   = list(string)
    untagged_ports = list(string)
  }))
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

