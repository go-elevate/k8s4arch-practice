### TO COMPLETE ###
#############################################################
# Replace here with your own AWS profile
variable "profile" {
  default     = ""
}

# Replace here with your own CIDR Block
variable "cidr_block" {
  default = ""
}

variable "ec2_ssh_key" {
  type    = string
  default = ""
}
#############################################################
variable "environment" {
  default = "develop"
}
variable "region" {
  default = "us-east-1"
}
variable "project" {
  default = "ges"
}

variable "delimiter" {
  type        = string
  default     = "-"
}
variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "kubernetes_labels" {
  type        = map(string)
  default     = {}
}
variable "apply_config_map_aws_auth" {
  type        = bool
  default     = false
}
variable "kubernetes_config_map_ignore_role_changes" {
  type        = bool
  default     = false
}
variable "name" {
  type        = string
  default     = "eks"
}
variable "endpoint_private_access" {
  type        = bool
  default     = true
}
variable "endpoint_public_access" {
  type        = bool
  default     = true
}
variable "public_access_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
variable "tags" {
  type    = map(string)
  default = {}
}
### CLUSTER ###
variable "kubernetes_version" {
  default = "1.18"
}
variable "local_exec_interpreter" {
  type    = list(string)
  default = ["/bin/sh", "-c"]
}
variable "oidc_provider_enabled" {
  type    = bool
  default = true
}
variable "enabled_cluster_log_types" {
  type    = list(string)
  default = ["audit"]
}
variable "cluster_log_retention_period" {
  type    = number
  default = 0
}
variable "map_additional_iam_roles" {
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}
variable "map_additional_iam_users" {
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}
variable "map_additional_aws_accounts" {
  type    = list(string)
  default = []
}
variable "enabled" {
  type    = bool
  default = true
}
### NODE GROUP ###
variable "eks_instance_types" {
  type        = list(string)
  default     = ["t3a.small"]
}
variable "eks_desired_size" {
  type        = number
  default     = 2
}
variable "eks_max_size" {
  type        = number
  default     = 3
}
variable "eks_min_size" {
  type        = number
  default     = 1
}
variable "eks_disk_size" {
  type        = number
  default     = 20
}
variable "use_launch_template" {
  type    = bool
  default = true
}
variable "ami_image_id" {
  type    = string
  default = "ami-040d914f5e85dab2c"
}
variable "launch_template_disk_encryption_enabled" {
  type    = bool
  default = true
}