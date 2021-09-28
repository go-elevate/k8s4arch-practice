resource "kubernetes_storage_class" "ceph_rbd" {
  count = var.ceph_enable ? 1 : 0
  metadata {
    name = "ceph-rbd"
    annotations = {
        "storageclass.kubernetes.io/is-default-class" = true
    }
  }

  storage_provisioner = "kubernetes.io/rbd"

  parameters = {
    # Ceph monitors, comma delimited. It is required.
    monitors = var.ceph_host
    # Ceph client ID that is capable of creating images in the pool. Default is admin.
    adminId: "admin"
    # Secret Name for adminId. It is required. The provided secret must have type kubernetes.io/rbd.
    adminSecretName: kubernetes_secret.ceph_rbd_secret_admin[count.index].metadata[0].name
    # The namespace for adminSecret. Default is default.
    adminSecretNamespace: "kube-system"
    # Ceph RBD pool. Default is rbd, but that value is not recommended.
    pool = "kube"
    # Ceph client ID that is used to map the Ceph RBD image. Default is the same as adminId.
    userId: "kube"
    # The name of Ceph Secret for userId to map Ceph RBD image. It must exist in the same namespace as PVCs.
    #     It is required unless its set as the default in new projects.
    userSecretName:  kubernetes_secret.ceph_rbd_secret_user[count.index].metadata[0].name
    # The namespace for userSecretName.
    userSecretNamespace = kubernetes_namespace.ceph_rbd[count.index].metadata[0].name
    fsType = "ext4"
    #  Ceph RBD image format, “1” or “2”. Default is “2”.
    imageFormat = "2"
    #  Currently supported features are layering only.
    imageFeatures = "layering"
  }

  depends_on = [
    rke_cluster.cluster,
    local_file.kube_cluster_yaml,
    kubernetes_secret.ceph_rbd_secret_admin,
    kubernetes_secret.ceph_rbd_secret_user,
  ]
}

resource "kubernetes_secret" "ceph_rbd_secret_admin" {
  count = var.ceph_enable ? 1 : 0
  metadata {
    name = "ceph-rbd-secret-admin"
    namespace = "kube-system"
  }

  data = {
    key = var.ceph_admin_key
  }

  # Required for Ceph RBD to work with dynamic provisioning.
  type = "kubernetes.io/rbd"

  depends_on = [
    rke_cluster.cluster,
    local_file.kube_cluster_yaml
  ]
}

resource "kubernetes_secret" "ceph_rbd_secret_user" {
  count = var.ceph_enable ? 1 : 0
  metadata {
    name = "ceph-rbd-secret-user"
    namespace = kubernetes_namespace.ceph_rbd[count.index].metadata[0].name
  }

  data = {  // todo get key with "ceph auth get-key client.kube | base64" command
    key = var.ceph_kube_key
  }

  # Required for Ceph RBD to work with dynamic provisioning.
  type = "kubernetes.io/rbd"

  depends_on = [
    rke_cluster.cluster,
    local_file.kube_cluster_yaml,
    kubernetes_namespace.ceph_rbd
  ]
}

resource "kubernetes_namespace" "ceph_rbd" {
  count = var.ceph_enable ? 1 : 0
  metadata {
    name = "ceph"
  }

  depends_on = [
    rke_cluster.cluster,
    local_file.kube_cluster_yaml
  ]
}