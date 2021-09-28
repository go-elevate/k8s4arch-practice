#---------------------------------------------------------------------------------------------------------------------
# SAVE Cluster Kube Config
# Copy the certificates in kubeconfig to access in the cluster
# ---------------------------------------------------------------------------------------------------------------------

# https://github.com/rancher/rke/issues/1682 :'(
# Fix:

resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kubeconfig/kube_config_cluster.yml"
  content = templatefile("${path.module}/templates/kubeconfig.yml.tpl", {
    external_ip                = var.external_ip,
    cluster_name               = var.cluster_name,
    certificate_authority_data = base64encode(rke_cluster.cluster.ca_crt),
    client_certificate_data    = base64encode(rke_cluster.cluster.client_cert),
    client_key_data            = base64encode(rke_cluster.cluster.client_key),
  })

  depends_on = [rke_cluster.cluster]
}

#---------------------------------------------------------------------------------------------------------------------
# SAVE Cluster State
# ---------------------------------------------------------------------------------------------------------------------
# resource "local_file" "rke_state" {
#   filename = "${path.root}/templates/cluster.rkestate"
#   content = rke_cluster.cluster.rke_state
# }

#---------------------------------------------------------------------------------------------------------------------
# SAVE Cluster Config
# ---------------------------------------------------------------------------------------------------------------------
# resource "local_file" "rke_cluster_yaml" {
#   filename = "${path.root}/templates/cluster.yml"
#   content = rke_cluster.cluster.rke_cluster_yaml
# }