locals {  
  dns_record_map = {
    for record in var.dns_records: record.name => record 
  }
}
