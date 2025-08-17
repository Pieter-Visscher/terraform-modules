variable "wifi_config" {
  description = "list of wifi configurations, first in list is used as primary, for actual config select the datapath/channel/security template name"
  type        = list(object({
    name      = string
    datapath  = string
    channel   = string
    security  = string
    ssid      = string
  }))
  default     = []
}

variable "wifi_channel" {
  description = "list of wifi channel configuration templates"
  type                = list(object({
    name              = string
    band              = string
    channel_width     = string
    skip_dfs          = string
    reselect_interval = string
    frequency         = list(number)
  }))
}

variable "wifi_country" {
  description = "your location, for wifi configuration"
  type        = string
}
variable "wifi_password" {
  description = "map of password in secrets.auto.tfvars"
  type        = map(string)
  sensitive   = true
  default     = {}
}
