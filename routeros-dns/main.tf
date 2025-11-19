resource "routeros_ip_dns_record" "dns" {
  for_each = local.dns_record_map

  name    = each.value.name
  address = each.value.address
  type    = each.value.type
}
