#variable "kubeconfig" {
#  type    = string
#}
#variable "l2lb" {
#  type    = bool
#  default = false
#}
#
#variable "qps" {
#  type    = number
#  default = 10
#}
#
#variable "burst" {
#  type    = number
#  default = 20
#}
#
#variable "api_server_host" {
#  type = string
#}
#
#variable "api_server_port" {
#  type = number
#}
variable "cilium_version" {
  type = string
}
variable "ip_pool_start" {
  type = string
}
variable "ip_pool_end" {
  type = string
}
variable "ip_pool_interface" {
  type = string
}
