/*
  COMMONS
*/

variable "one_username" {
  type        = string
  description = "Open Nebula user"
}

variable "one_password" {
  type        = string
  description = "Open Nebula user password"
}

variable "one_endpoint" {}

/*
  RKE NODES - VARIABLES
*/

variable "cluster_name" {
  type = string
}

variable "image_name" {
  type        = string
  description = "OS Image"
}

variable "vnet" {
  type        = string
  description = "Name of the existent virtual net"
}

variable "ssh_key" {
  type        = string
  description = "Key for VM CA"
}

/*
  CEPH
*/

variable "ceph_admin_key" {
  type = string
}

variable "ceph_kube_key" {
  type = string
}