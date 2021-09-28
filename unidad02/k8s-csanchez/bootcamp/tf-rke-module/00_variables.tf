/*
  RKE
*/

variable "node_addresses" {
  type = list(string)
}

variable "cluster_name" {
  type = string
}

variable "system_username" {
  type = string
}

variable "external_ip" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "v1.20.4-rancher1-1"
}

variable "max_pods_per_node" {
  type    = number
  default = 55
}

variable "addon_job_timeout" {
  type    = number
  default = 180
}

variable "ssh_key" {
  type = string
}

/*
  RKE NAMESPACES
*/
variable "create_core_namespaces" {
  type = bool
}

variable "core_namespaces" {
  type = list(string)
  default = []
}

/*
  CEPH SETTINGS
*/

variable "ceph_enable" {
  type = bool
}
variable "ceph_host" {
  type = string
}

variable "ceph_admin_key" {
  type = string
}

variable "ceph_kube_key" {
  type = string
}

/*
  NGINX INGRESS CONTROLLER
*/

variable "nginx_enable" {
  type = bool
}
variable "nginx_namespace" {
  type = string
  default = "nginx"
}

variable "helm_repo" {
  default = "https://kubernetes.github.io/ingress-nginx"
}

variable "external_nodes_ip" {
  type = list(string)
}

variable "nginx_min_replicas" {
  type = number
}

variable "nginx_max_replicas" {
  type = number
}

variable "nginx_force_update" {
  type = bool
}

variable "nginx_recreate_pods" {
  type = bool
}

/*
  METRICS SERVER
*/

variable "metrics_enable" {
  type = bool
}

variable "metrics_tag_version" {
  type = string
  default = "v0.4.1"
}