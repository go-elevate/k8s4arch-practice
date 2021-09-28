# https://rancher.com/docs/rancher/v2.x/en/cluster-provisioning/production/

/*

Cluster Architecture
    Nodes should have one of the following role configurations:
        etcd
        controlplane
        etcd and controlplane
        worker (the worker role should not be used or added on nodes with the etcd or controlplane role)
    Have at least three nodes with the role etcd to survive losing one node. Increase this count for higher node fault toleration, and spread them across (availability) zones to provide even better fault tolerance.
    Assign two or more nodes the controlplane role for master component high availability.
    Assign two or more nodes the worker role for workload rescheduling upon node failure.

*/

module "k8s_nodes" {
    source = "./tf-on-vms-module"
    
    naming = "rke-bootcamp-node"

    # Settings
    vm_type = "basic" # Defaults: basic
    replicas = 3 # Defaults: 1
    ssh_key = var.ssh_key

    # Software
    so_image = var.image_name
    install_docker = true # If set this, override the default command value

    # Hardware
    cpu = 2
    ram = 8
    disk_size = 15000

    # Networkings
    vnet = var.vnet
}

module "proxy_vm" {
    source = "git::https://bitbucket.org/madeofgenes/tf-on-vms-module.git?ref=v1.0.3"

    naming = "rke-bootcamp-proxy"

    # Settings
    vm_type = "proxy"
    ssh_key = var.ssh_key
    backend_ips = module.k8s_nodes.ip_k8s_nodes

    # Software
    so_image = var.image_name

    # Hardware
    cpu = 1
    ram = 1
    disk_size = 10000

    # Networkings
    vnet = var.vnet

    depends_on = [module.k8s_nodes]
}