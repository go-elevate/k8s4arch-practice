output "kubernetes_external_ip" {
  value = var.external_ip
}

output "certificate_authority_data" {
  value = base64encode(rke_cluster.cluster.ca_crt)
}

output "core_namespaces" {
  value = toset(var.core_namespaces)
}

output "storage_class_rke" {
  value = join("", kubernetes_storage_class.ceph_rbd[*].metadata[0].name)
}