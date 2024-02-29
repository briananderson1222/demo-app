## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.16.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.16.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.26.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_artifact_registry_repository.artifact-repo](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/artifact_registry_repository) | resource |
| [google_artifact_registry_repository_iam_member.cicd](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/artifact_registry_repository_iam_member) | resource |
| [google_artifact_registry_repository_iam_member.cluster](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/artifact_registry_repository_iam_member) | resource |
| [google_container_cluster.primary](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/container_cluster) | resource |
| [google_iam_workload_identity_pool.github](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.github-automation](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_project_iam_binding.cluster-roles](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/project_iam_binding) | resource |
| [google_project_iam_member.cicd-container-developer](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/project_iam_member) | resource |
| [google_project_service.cloudresource](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/project_service) | resource |
| [google_service_account.cicd](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/service_account) | resource |
| [google_service_account.cluster](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/service_account) | resource |
| [google_service_account_iam_member.cicd-workload-identity](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/resources/service_account_iam_member) | resource |
| [kubernetes_namespace.development](https://registry.terraform.io/providers/hashicorp/kubernetes/2.26.0/docs/resources/namespace) | resource |
| [kubernetes_namespace.production](https://registry.terraform.io/providers/hashicorp/kubernetes/2.26.0/docs/resources/namespace) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/5.16.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster-name"></a> [cluster-name](#input\_cluster-name) | Name of the K8s cluster to create | `string` | `"autopilot-cluster-1"` | no |
| <a name="input_google_project_id"></a> [google\_project\_id](#input\_google\_project\_id) | n/a | `string` | `"brian-dev-1222"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region used for creating resources | `string` | `"us-central1"` | no |
| <a name="input_registry-name"></a> [registry-name](#input\_registry-name) | Name of artifact registry used for storing images | `string` | `"container-registry"` | no |

## Outputs

No outputs.
