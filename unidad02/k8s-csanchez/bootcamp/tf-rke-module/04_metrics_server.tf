resource "helm_release" "metrics_server" {
  count = var.metrics_enable ? 1 : 0
  name      = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart     = "metrics-server"
  namespace = "kube-system"
  timeout = 200
  wait = true


    values = [templatefile("${path.module}/templates/metrics-server.yml.tpl", {
        tag_version = var.metrics_tag_version
    })]

  force_update = var.nginx_force_update  // Force resource update through delete/recreate if needed.
  recreate_pods = var.nginx_recreate_pods

  depends_on = [rke_cluster.cluster]
}