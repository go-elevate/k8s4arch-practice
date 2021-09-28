resource "kubernetes_namespace" "core_namespaces" {
  for_each = var.create_core_namespaces ? toset(var.core_namespaces) : []
  metadata {
    name = each.key
  }

  depends_on = [
    rke_cluster.cluster,
    local_file.kube_cluster_yaml
  ]
}