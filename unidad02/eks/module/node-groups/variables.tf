variable "environment" {
  type = string
}
variable "delimiter" {
  type    = string
  default = "-"
}
variable "attributes" {
  type    = list(string)
  default = []
}
variable "enabled" {
  type    = bool
  default = true
}
variable "enable_cluster_autoscaler" {
  type    = bool
  default = false
}
variable "cluster_name" {
  type = string
}
variable "ec2_ssh_key" {
  type    = string
  default = null
}
variable "desired_size" {
  type = number
}
variable "max_size" {
  type = number
}
variable "min_size" {
  type = number
}
variable "subnet_ids" {
  type = list(string)
}
variable "existing_workers_role_policy_arns" {
  type    = list(string)
  default = []
}
variable "existing_workers_role_policy_arns_count" {
  type    = number
  default = 0
}
variable "ami_type" {
  type    = string
  default = "AL2_x86_64"
}
variable "disk_size" {
  type    = number
  default = 20
}
variable "disk_type" {
  type    = string
  default = null
}
variable "instance_types" {
  type = list(string)
}
variable "kubernetes_labels" {
  type    = map(string)
  default = {}
}
variable "ami_image_id" {
  type    = string
  default = null
}
variable "ami_release_version" {
  type    = string
  default = null
}
variable "kubernetes_version" {
  type    = string
  default = null
}
variable "source_security_group_ids" {
  type    = list(string)
  default = []
}
variable "allowed_cidr_blocks_node_group" {
  type    = list(string)
  default = []
}
variable "module_depends_on" {
  type    = any
  default = null
}
variable "launch_template_disk_encryption_enabled" {
  type    = bool
  default = false
}
variable "launch_template_disk_encryption_kms_key_id" {
  type    = string
  default = ""
}
variable "use_launch_template" {
  type    = bool
  default = false
}
variable "resources_to_tag" {
  type    = list(string)
  default = []
  validation {
    condition = (
      length(compact([for r in var.resources_to_tag : r if ! contains(["instance", "volume", "elastic-gpu", "spot-instances-request"], r)])) == 0
    )
    error_message = "Invalid resource type in `resources_to_tag`. Valid types are \"instance\", \"volume\", \"elastic-gpu\", \"spot-instances-request\"."
  }
}
variable "project" {
  type = string
}
variable "vpc_id" {
  type = string
}