image:
  tag: "${tag_version}"
hostNetwork:
  enabled: true
args:
  - --cert-dir=/tmp
  - --secure-port=4443
  - --kubelet-preferred-address-types=InternalIP
  - --kubelet-use-node-status-port
  - --kubelet-insecure-tls=true