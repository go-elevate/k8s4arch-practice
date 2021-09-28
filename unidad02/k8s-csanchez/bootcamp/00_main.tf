# ---------------------------------------------------------------------------------------------------------------------
# BACKEND CONFIGURATION
# Backend configuration is loaded early so we can't use variables
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = "~> 0.14.0"

  backend "s3" {
    region = "eu-central-1"
    bucket = "gc-terraform-tfstate-eu-central-1"
    key    = "tf-rke-cluster/bootcamp/terraform.tfstate"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# PROVIDERS CONFIGURATION BLOCK
# ---------------------------------------------------------------------------------------------------------------------

provider "aws" {
  
  region  = var.region
  profile = "default"

}

provider "opennebula" {
  endpoint = var.one_endpoint
  username = var.one_username
  password = var.one_password
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# RKE provider
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

provider "rke" {}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CONFIGURE KUBERNETES PROVIDER
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
provider "kubernetes" {
  config_path    = "kubeconfig/kube_config_cluster.yml"
  config_context = var.cluster_name
}

provider "helm" {
  kubernetes {
    config_path    = "kubeconfig/kube_config_cluster.yml"
    config_context = var.cluster_name
  }
}