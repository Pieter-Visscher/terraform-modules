variable "dns" {
  description = "dns records"
  type        = list(object({
    name      = string
    address   = string
    type      = string
  }))
}
