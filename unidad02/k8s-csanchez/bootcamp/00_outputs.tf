output "ip_nodes" {
  value = module.k8s_nodes.ip_k8s_nodes
}

output "ip_proxy_node" {
  value = module.proxy_vm.ip_proxy_node
}

## RKE

output "kubernetes_external_ip" {
  value = module.rke_cluster.kubernetes_external_ip
}

output "certificate_authority_data" {
  value = module.rke_cluster.certificate_authority_data
}

## Ingress IP's

# output "ingress_ips_to_proxy" {
#   value = data.kubernetes_ingress.example.status.0.load_balancer.0.ingress.0.ip
# }