terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.34.0"
    }
    opennebula = {
      source  = "OpenNebula/opennebula"
      version = "0.3.0"
    }
    rke = {
      source  = "rancher/rke"
      version = "1.2.1"
    }
  }
  required_version = "~> 0.14.0"
}