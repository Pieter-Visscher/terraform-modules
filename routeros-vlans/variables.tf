variable "vlans" {
  description = "List of vlans present on your Mikrotik device"
  type = list(object({
    name           = string
    id        = number
    tagged   = list(string)
    untagged = list(string)
  }))
  default = []
}

variable "default_cidr" {
  description = "Default cidr used as base for all subnets"
  type        = string
}

