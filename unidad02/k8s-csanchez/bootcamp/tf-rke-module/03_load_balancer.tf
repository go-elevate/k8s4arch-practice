# Install nginx via Helm Chart
resource "helm_release" "nginx" {
  count = var.nginx_enable ? 1 : 0
  name      = "ingress-nginx"
  repository = var.helm_repo
  chart     = "ingress-nginx"
  namespace = kubernetes_namespace.nginx[count.index].metadata[0].name
  wait = true

  values = [templatefile("${path.module}/templates/ingress-nginx.yml.tpl", {
        nginx_min_replicas = var.nginx_min_replicas,
        nginx_max_replicas = var.nginx_max_replicas,
        external_nodes_ip = var.external_nodes_ip
  })]

  force_update = var.nginx_force_update  // Force resource update through delete/recreate if needed.
  recreate_pods = var.nginx_recreate_pods

  depends_on = [
    rke_cluster.cluster,
    local_file.kube_cluster_yaml,
    kubernetes_namespace.nginx
  ]

}

resource "kubernetes_namespace" "nginx" {
  count = var.nginx_enable ? 1 : 0
  metadata {
    name = var.nginx_namespace
    labels = {
      name = var.nginx_namespace
    }
  }

  depends_on = [
    rke_cluster.cluster,
    local_file.kube_cluster_yaml
  ]

}

# Get DNS name of the ELBv1 from Nginx Service created by the Ingress Controller.
data "kubernetes_service" "nginx" {
  count = var.nginx_enable ? 1 : 0
  metadata {
    namespace = var.nginx_namespace
    name ="${helm_release.nginx[count.index].name}-controller"
  }

  depends_on = [
    rke_cluster.cluster,
    local_file.kube_cluster_yaml,
    helm_release.nginx
  ]

}