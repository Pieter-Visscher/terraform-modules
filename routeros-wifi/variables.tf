variable "CAPsMAN" {
  description = "Enable Capsman"
  type        = bool
  default     = false
}

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

variable "wifi_datapath" {
  description         = "list of datapath configuration templates"
  type                = list(object({
    name              = string
    vlan_id           = string
    client_isolation  = bool
    bridge            = string
  }))
}

variable "wifi_passwords" {
  description = "map of password in secrets.auto.tfvars"
  type        = map(string)
  sensitive   = true
  default     = {}
}

variable "wifi_security" {
  description             = "security settings"
  type                    = list(object({
    name                  = string
    authentication_types  = list(string)
    ft                    = bool
    ft-over-ds            = bool
    management_encryption = string
  }))
