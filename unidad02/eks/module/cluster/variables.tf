variable "environment" {
  type        = string
}
variable "enabled" {
  type        = bool
  default     = true
}
variable "delimiter" {
  type        = string
  default     = "-"
}
variable "attributes" {
  type        = list(string)
  default     = []
}
variable "region" {
  type        = string
}
variable "vpc_id" {
  type        = string
}
variable "subnet_ids" {
  type        = list(string)
}
variable "allowed_security_groups" {
  type        = list(string)
  default     = []
}
variable "allowed_cidr_blocks" {
  type        = list(string)
  default     = []
}
variable "workers_role_arns" {
  type        = list(string)
  default     = []
}
variable "workers_security_group_ids" {
  type        = list(string)
  default     = []
}
variable "kubernetes_version" {
  type        = string
  default     = "1.15"
}
variable "oidc_provider_enabled" {
  type        = bool
  default     = false
}
variable "endpoint_private_access" {
  type        = bool
  default     = false
}
variable "endpoint_public_access" {
  type        = bool
  default     = true
}
variable "public_access_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
variable "enabled_cluster_log_types" {
  type        = list(string)
  default     = []
}
variable "cluster_log_retention_period" {
  type        = number
  default     = 0
}
variable "apply_config_map_aws_auth" {
  type        = bool
  default     = true
}
variable "map_additional_aws_accounts" {
  type        = list(string)
  default     = []
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
variable "local_exec_interpreter" {
  type        = list(string)
  default     = ["/bin/sh", "-c"]
}
variable "wait_for_cluster_command" {
  type        = string
  default     = "curl --silent --fail --retry 60 --retry-delay 5 --retry-connrefused --insecure --output /dev/null $ENDPOINT/healthz"
}
variable "kubernetes_config_map_ignore_role_changes" {
  type        = bool
  default     = true
}
variable "project" {
  type        = string
}