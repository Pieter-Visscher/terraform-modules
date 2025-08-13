variable "vlans" {
  description = "List of vlans present on your Mikrotik device"
  type = list(object({
    name           = string
    id             = number
    tagged_ports   = list(string)
    untagged_ports = list(string)
  }))
  default = []
}

variable "bridges" {
  description = "List of vlans present on your Mikrotik device"
  type = list(object({
    name           = string
    pvid           = number
  }))
  default = []
}

variable "default_cidr" {
  description = "Default cidr used as base for all subnets"
  type        = string
}

