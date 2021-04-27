locals {
  tags                       = merge(var.tags, map("kubernetes.io/cluster/${var.name}", "shared"))
  eks_worker_ami_name_filter = "amazon-eks-node-${var.kubernetes_version}*"
  ### Complete these three below variables
  vpc_id                     = ""
  public_subnets             = ["", ""]
  private_subnets            = ["", ""]
  subnet_ids                 = concat(local.public_subnets, local.private_subnets)
}

module "eks_cluster" {
  source                                    = "../module/cluster"
  environment                               = var.environment
  region                                    = var.region
  vpc_id                                    = local.vpc_id
  subnet_ids                                = local.subnet_ids
  kubernetes_version                        = var.kubernetes_version
  local_exec_interpreter                    = var.local_exec_interpreter
  oidc_provider_enabled                     = var.oidc_provider_enabled
  enabled_cluster_log_types                 = var.enabled_cluster_log_types
  cluster_log_retention_period              = var.cluster_log_retention_period
  map_additional_iam_roles                  = var.map_additional_iam_roles
  map_additional_iam_users                  = var.map_additional_iam_users
  map_additional_aws_accounts               = var.map_additional_aws_accounts
  enabled                                   = var.enabled
  apply_config_map_aws_auth                 = var.apply_config_map_aws_auth
  kubernetes_config_map_ignore_role_changes = var.kubernetes_config_map_ignore_role_changes
  endpoint_private_access                   = var.endpoint_private_access
  endpoint_public_access                    = var.endpoint_public_access
  allowed_cidr_blocks                       = [var.cidr_block]
  project                                   = var.project
}

data "null_data_source" "wait_for_cluster_and_kubernetes_configmap" {
  inputs = {
    cluster_name             = module.eks_cluster.eks_cluster_id
    kubernetes_config_map_id = module.eks_cluster.kubernetes_config_map_id
  }
}

module "eks_node_group" {
  source                                  = "../module/node-groups"
  environment                             = var.environment
  subnet_ids                              = local.public_subnets
  cluster_name                            = data.null_data_source.wait_for_cluster_and_kubernetes_configmap.outputs["cluster_name"]
  instance_types                          = var.eks_instance_types
  desired_size                            = var.eks_desired_size
  min_size                                = var.eks_min_size
  max_size                                = var.eks_max_size
  disk_size                               = var.eks_disk_size
  project                                 = var.project
  ec2_ssh_key                             = var.ec2_ssh_key
  vpc_id                                  = local.vpc_id
  allowed_cidr_blocks_node_group          = [var.cidr_block]
  use_launch_template                     = var.use_launch_template
  ami_image_id                            = var.ami_image_id
  launch_template_disk_encryption_enabled = var.launch_template_disk_encryption_enabled
}