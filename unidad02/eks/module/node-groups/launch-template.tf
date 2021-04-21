locals {
  launch_template_ami = length(local.configured_ami_image_id) == 0 ? "" : local.configured_ami_image_id
  launch_template_vpc_security_group_ids = (
    local.need_remote_access_sg ?
    concat(aws_security_group.remote_access.*.id) : []
  )
  cluster_data = {
    cluster_name = var.cluster_name
  }
}
### LAUNCH TEMPLATE ###
resource "aws_launch_template" "default" {
  count = (var.enabled && var.use_launch_template) ? 1 : 0
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.disk_size
      volume_type = var.disk_type
      kms_key_id  = var.launch_template_disk_encryption_enabled && length(var.launch_template_disk_encryption_kms_key_id) > 0 ? var.launch_template_disk_encryption_kms_key_id : null
      encrypted   = var.launch_template_disk_encryption_enabled
    }
  }
  name                   = "LT-NG-EKS-${upper(var.environment)}-${upper(var.project)}"
  update_default_version = true
  image_id               = local.launch_template_ami == "" ? null : local.launch_template_ami
  key_name               = local.have_ssh_key ? var.ec2_ssh_key : null
  metadata_options {
    http_put_response_hop_limit = 2
    http_endpoint               = "enabled"
  }
  vpc_security_group_ids = local.launch_template_vpc_security_group_ids
  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="
--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"
#!/bin/bash
/etc/eks/bootstrap.sh eks-br-sandbox-terraform-09
--==MYBOUNDARY==--\
  EOF
  )
}