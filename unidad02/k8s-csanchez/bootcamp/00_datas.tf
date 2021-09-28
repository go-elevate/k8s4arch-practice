# Load the group
data "opennebula_group" "group" {
  name = var.one_username
}

# Get datacenter's virtual network
data "opennebula_virtual_network" "vnet" {
  name = var.vnet
}

#Get image from opennebula
data "opennebula_image" "image" {
  name = var.image_name
}

# data "kubernetes_ingress" "example" {
#   metadata {
#     name = "fileservice-ingress"
#     namespace = "staging"
#   }
# }