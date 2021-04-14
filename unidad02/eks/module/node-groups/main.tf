locals {
  node_group_tags = merge(
    {
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    },
    {
      "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    },
    {
      "k8s.io/cluster-autoscaler/enabled" = "${var.enable_cluster_autoscaler}"
    }
  )
  aws_policy_prefix       = format("arn:%s:iam::aws:policy", join("", data.aws_partition.current.*.partition))
  sg_name                 = "SG-NG-EKS-${upper(var.environment)}-${upper(var.project)}"
  have_ssh_key            = var.ec2_ssh_key != null && var.ec2_ssh_key != ""
  need_remote_access_sg   = var.enabled && local.have_ssh_key
  configured_ami_image_id = var.ami_image_id == null ? "" : var.ami_image_id
}

data "aws_partition" "current" {
  count = var.enabled ? 1 : 0
}

data "aws_iam_policy_document" "assume_role" {
  count = var.enabled ? 1 : 0

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "amazon_eks_worker_node_autoscaler_policy" {
  count = (var.enabled && var.enable_cluster_autoscaler) ? 1 : 0
  statement {
    sid = "AllowToScaleEKSNodeGroupAutoScalingGroup"

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "ec2:DescribeLaunchTemplateVersions"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "amazon_eks_worker_node_autoscaler_policy" {
  count  = (var.enabled && var.enable_cluster_autoscaler) ? 1 : 0
  name   = "autoscaler-eks-${lower(var.environment)}-${lower(var.project)}"
  path   = "/"
  policy = join("", data.aws_iam_policy_document.amazon_eks_worker_node_autoscaler_policy.*.json)
}

resource "aws_iam_role" "default" {
  count              = var.enabled ? 1 : 0
  name               = "role-ng-eks-${lower(var.environment)}-${lower(var.project)}"
  assume_role_policy = join("", data.aws_iam_policy_document.assume_role.*.json)
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  count      = var.enabled ? 1 : 0
  policy_arn = format("%s/%s", local.aws_policy_prefix, "AmazonEKSWorkerNodePolicy")
  role       = join("", aws_iam_role.default.*.name)
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_autoscaler_policy" {
  count      = (var.enabled && var.enable_cluster_autoscaler) ? 1 : 0
  policy_arn = join("", aws_iam_policy.amazon_eks_worker_node_autoscaler_policy.*.arn)
  role       = join("", aws_iam_role.default.*.name)
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  count      = var.enabled ? 1 : 0
  policy_arn = format("%s/%s", local.aws_policy_prefix, "AmazonEKS_CNI_Policy")
  role       = join("", aws_iam_role.default.*.name)
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  count      = var.enabled ? 1 : 0
  policy_arn = format("%s/%s", local.aws_policy_prefix, "AmazonEC2ContainerRegistryReadOnly")
  role       = join("", aws_iam_role.default.*.name)
}

resource "aws_iam_role_policy_attachment" "existing_policies_for_eks_workers_role" {
  count      = var.enabled ? var.existing_workers_role_policy_arns_count : 0
  policy_arn = var.existing_workers_role_policy_arns[count.index]
  role       = join("", aws_iam_role.default.*.name)
}

resource "aws_eks_node_group" "default" {
  count           = var.enabled ? 1 : 0
  cluster_name    = var.cluster_name
  node_group_name = "ng-eks-${lower(var.environment)}-${lower(var.project)}"
  node_role_arn   = join("", aws_iam_role.default.*.arn)
  subnet_ids      = var.subnet_ids
  ami_type        = local.launch_template_ami == "" ? var.ami_type : null
  disk_size       = var.use_launch_template ? null : var.disk_size
  instance_types  = var.instance_types
  labels          = var.kubernetes_labels
  release_version = local.launch_template_ami == "" ? var.ami_release_version : null
  version         = length(compact([local.launch_template_ami, var.ami_release_version])) == 0 ? var.kubernetes_version : null


  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  dynamic "remote_access" {
    for_each = var.ec2_ssh_key != null && var.ec2_ssh_key != "" && var.use_launch_template == false ? ["true"] : []
    content {
      ec2_ssh_key               = var.ec2_ssh_key
      source_security_group_ids = [join("", aws_security_group.remote_access.*.id)]
    }
  }

  dynamic "launch_template" {
    for_each = var.use_launch_template ? ["true"] : []
    content {
      id      = aws_launch_template.default[0].id
      version = aws_launch_template.default[0].latest_version
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
    aws_iam_role_policy_attachment.amazon_eks_worker_node_autoscaler_policy,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
    var.module_depends_on
  ]

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}

resource "aws_security_group" "remote_access" {
  count       = local.need_remote_access_sg ? 1 : 0
  name        = local.sg_name
  description = "Allow SSH access to all nodes in the nodeGroup"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "egress" {
  count             = var.enabled ? 1 : 0
  description       = "Allow all egress traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.remote_access.*.id)
  type              = "egress"
}
resource "aws_security_group_rule" "remote_access_public_ssh" {
  count       = local.need_remote_access_sg && length(var.allowed_cidr_blocks_node_group) == 0 ? 1 : 0
  description = "Allow SSH access to nodes from anywhere"
  type        = "ingress"
  protocol    = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = join("", aws_security_group.remote_access.*.id)
}

resource "aws_security_group_rule" "remote_access_source_cidr_ssh" {
  count       = var.enabled && length(var.allowed_cidr_blocks_node_group) > 0 ? 1 : 0
  description = "Allow SSH access to nodes from security group"
  type        = "ingress"
  protocol    = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_blocks = var.allowed_cidr_blocks_node_group

  security_group_id = aws_security_group.remote_access[0].id
}

resource "aws_security_group_rule" "remote_access_source_sgs_ssh" {
  for_each    = local.need_remote_access_sg ? toset(var.source_security_group_ids) : []
  description = "Allow SSH access to nodes from security group"
  type        = "ingress"
  protocol    = "tcp"
  from_port   = 22
  to_port     = 22

  security_group_id        = aws_security_group.remote_access[0].id
  source_security_group_id = each.value
}

resource "aws_security_group_rule" "ingress_cidr_blocks" {
  count             = var.enabled && length(var.allowed_cidr_blocks_node_group) > 0 ? 1 : 0
  description       = "Allow inbound traffic from CIDR blocks"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = var.allowed_cidr_blocks_node_group
  security_group_id = join("", aws_security_group.remote_access.*.id)
  type              = "ingress"
}