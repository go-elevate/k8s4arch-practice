# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CONFIGURE RKE KUBERNETES
# See https://registry.terraform.io/providers/rancher/rke/latest/docs/resources/cluster
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Create a RKE cluster

module "rke_cluster" {
    source = "./tf-rke-module"
    
    cluster_name = var.cluster_name

    # Settings
    node_addresses = module.k8s_nodes.ip_k8s_nodes
    external_ip = "212.36.67.214"
    kubernetes_version = "v1.20.4-rancher1-1"
    max_pods_per_node = 55
    addon_job_timeout = 180

    # Software
    system_username = var.one_username
    ssh_key = var.ssh_key

  # Namespaces
  create_core_namespaces = true
  core_namespaces        = ["jordi-cami", "alex-molina","charlie-sanchez"]
  # Ceph RBD Config
  ceph_enable    = true
  ceph_host      = "10.1.2.1:6789,10.1.2.2:6789,10.1.2.3:6789" // LB s1: 10.1.2.1 / s2: 10.1.2.2 / s3: 10.1.2.3
  ceph_admin_key = var.ceph_admin_key
  ceph_kube_key  = var.ceph_kube_key

  # Nginx Ingress Controller
  nginx_enable        = true
  external_nodes_ip   = module.k8s_nodes.ip_k8s_nodes
  nginx_min_replicas  = 1
  nginx_max_replicas  = 2
  nginx_force_update  = true
  nginx_recreate_pods = true

  # Metrics-server
  metrics_enable = false
  metrics_tag_version = "v0.5.0"

  depends_on = [
    module.k8s_nodes,
    module.proxy_vm
  ]
}