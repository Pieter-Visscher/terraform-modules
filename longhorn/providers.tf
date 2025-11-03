#provider "helm" {
#  kubernetes {
#    host = "https://${module.evangelion.vip}:6443"
#
#    client_certificate      = base64decode(module.evangelion.machinesecrets.client_configuration.client_certificate)
#    client_key              = base64decode(module.evangelion.machinesecrets.client_configuration.client_key)
#    cluster_ca_certificate  = base64decode(module.evangelion.machinesecrets.client_configuration.ca_certificate)
#  }
#}
