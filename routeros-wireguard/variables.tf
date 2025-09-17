variable "default_cidr" {
  description = "Default cidr used as base for all subnets"
  type        = string
}

variable "vpn_interface_address" {
  type = string
  description = "address inside the vpn subnet. Base subnet + vpn_interface_subnet is used to compile complete subnet in cidr notation"
}

variable "vpn_interface_subnet" {
  type = string
  description = "subnet used for the VPN network"
}

variable "vpn_peers" {
  type  = list(object({
    name        = string
    psk         = string
    public_key  = string
    subnets     = list(string)
    id          = number
    comment     = string
  }))
  default = []
}
