## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_rke"></a> [rke](#requirement\_rke) | 1.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_rke"></a> [rke](#provider\_rke) | 1.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.kube_cluster_yaml](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [rke_cluster.cluster](https://registry.terraform.io/providers/rancher/rke/1.2.1/docs/resources/cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addon_job_timeout"></a> [addon\_job\_timeout](#input\_addon\_job\_timeout) | n/a | `number` | `180` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_external_ip"></a> [external\_ip](#input\_external\_ip) | n/a | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | n/a | `string` | `"v1.20.4-rancher1-1"` | no |
| <a name="input_max_pods_per_node"></a> [max\_pods\_per\_node](#input\_max\_pods\_per\_node) | n/a | `number` | `55` | no |
| <a name="input_node_addresses"></a> [node\_addresses](#input\_node\_addresses) | n/a | `list(string)` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | n/a | `string` | n/a | yes |
| <a name="input_system_username"></a> [system\_username](#input\_system\_username) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
