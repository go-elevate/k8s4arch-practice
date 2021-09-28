# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CONFIGURE RKE KUBERNETES
# See https://registry.terraform.io/providers/rancher/rke/latest/docs/resources/cluster
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Create a new RKE cluster using arguments
resource "rke_cluster" "cluster" {

  # Set cluster name
  cluster_name = var.cluster_name

  # Ignore docker installed version
  ignore_docker_version = false

  #########################################################
  # Configure nodes - all of them will be configured as a master and worker
  #########################################################

  dynamic "nodes" {
    for_each = toset(var.node_addresses)
    content {
      address = nodes.value
      user    = var.system_username
      role    = ["controlplane", "worker", "etcd"]
      ssh_key = file("~/.ssh/${var.ssh_key}")
    }
  }

  ################################################
  # Authentication
  ################################################
  # Currently, only authentication strategy supported is x509.
  # You can optionally create additional SANs (hostnames or IPs) to add to the API server PKI certificate.
  # This is useful if you want to use a load balancer for the control plane servers.

  authentication {
    strategy = "x509"
    sans = [
      var.external_ip,
    ]
  }

  #########################################################
  # K8S VERSION - supported: v1.15.3-rancher1-1/ v1.15.5-rancher2-2
  #########################################################
  kubernetes_version = var.kubernetes_version

  ###############################################
  # Kubernetes services
  ###############################################
  services {
    kube_api {
      extra_args = {
        external-hostname = var.external_ip
      }
    }

    kubelet {
      # Optionally define additional volume binds to a service
      extra_binds = [
        "/lib/modules:/lib/modules", # we need this to use RBD module
        "/usr/sbin/modprobe:/usr/sbin/modprobe"
      ]
      extra_args = {
        # set max pods
        max-pods = var.max_pods_per_node
      }
    }

  }

  # Add-ons are deployed using kubernetes jobs. RKE will give up on trying to get the job status after this timeout in seconds..
  addon_job_timeout = var.addon_job_timeout

  #########################################################
  # Network(CNI) - supported: flannel/calico/canal/weave
  #########################################################
  network {
    plugin = "canal"
    options = {
      canal_flannel_backend_type = "vxlan"
    }
  }

  dns {
    provider = "coredns"
  }

  ################################################
  # Ingress
  # To disable ingress controller, set `provider: none`
  # To enable set `provider: nginx`
  ################################################
  ingress {
    provider = "none"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

}