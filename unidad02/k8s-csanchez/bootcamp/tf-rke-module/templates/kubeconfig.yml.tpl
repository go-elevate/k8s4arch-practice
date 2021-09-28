apiVersion: v1
kind: Config
clusters:
- cluster:
    api-version: v1
    certificate-authority-data: ${certificate_authority_data}
    server: "https://${external_ip}:6443"
  name: "${cluster_name}"
contexts:
- context:
    cluster: "${cluster_name}"
    user: "kube-admin-${cluster_name}"
  name: "${cluster_name}"
current-context: "${cluster_name}"
users:
- name: "kube-admin-${cluster_name}"
  user:
    client-certificate-data: ${client_certificate_data}
    client-key-data: ${client_key_data}