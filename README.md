# Velero installation on AWS EKS Kubernetes

Deploy velero to Kubernetes.

---

![](https://github.com/terraform-module/terraform-kubernetes-velero/workflows/release/badge.svg)
![](https://github.com/terraform-module/terraform-kubernetes-velero/workflows/commit-check/badge.svg)
![](https://github.com/terraform-module/terraform-kubernetes-velero/workflows/labeler/badge.svg)

[![](https://img.shields.io/github/license/terraform-module/terraform-kubernetes-velero)](https://github.com/terraform-module/terraform-kubernetes-velero)
![](https://img.shields.io/github/v/tag/terraform-module/terraform-kubernetes-velero)
![](https://img.shields.io/issues/github/terraform-module/terraform-kubernetes-velero)
![](https://img.shields.io/github/issues/terraform-module/terraform-kubernetes-velero)
![](https://img.shields.io/github/issues-closed/terraform-module/terraform-kubernetes-velero)
[![](https://img.shields.io/github/languages/code-size/terraform-module/terraform-kubernetes-velero)](https://github.com/terraform-module/terraform-kubernetes-velero)
[![](https://img.shields.io/github/repo-size/terraform-module/terraform-kubernetes-velero)](https://github.com/terraform-module/terraform-kubernetes-velero)
![](https://img.shields.io/github/languages/top/terraform-module/terraform-kubernetes-velero?color=green&logo=terraform&logoColor=blue)
![](https://img.shields.io/github/commit-activity/m/terraform-module/terraform-kubernetes-velero)
![](https://img.shields.io/github/contributors/terraform-module/terraform-kubernetes-velero)
![](https://img.shields.io/github/last-commit/terraform-module/terraform-kubernetes-velero)
[![Maintenance](https://img.shields.io/badge/Maintenu%3F-oui-green.svg)](https://GitHub.com/terraform-module/terraform-kubernetes-velero/graphs/commit-activity)
[![GitHub forks](https://img.shields.io/github/forks/terraform-module/terraform-kubernetes-velero.svg?style=social&label=Fork)](https://github.com/terraform-module/terraform-kubernetes-velero)

---

## References

- [Velero Providers](https://velero.io/docs/master/supported-providers/)
- [Velero BackupStorage](https://velero.io/docs/master/api-types/backupstoragelocation/)
- [Velero Basic Install](https://velero.io/docs/v1.4/basic-install/)
- [Velero Daily Backup/Disaster Recovery](https://velero.io/docs/v1.4/disaster-case/)
- [Velero Cluster Migration](https://velero.io/docs/v1.4/migration-case/)
- [Velero AWS Plugin](https://github.com/vmware-tanzu/velero-plugin-for-aws)

- [Chart installation](https://github.com/vmware-tanzu/helm-charts/blob/master/charts/velero/README.md)
- [Velero Helm Chart](https://github.com/vmware-tanzu/velero)
- [AWS Setup](https://github.com/vmware-tanzu/velero-plugin-for-aws#setup)
- [AWS CSI Driver](https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html)
- [Cassandra Example](https://velero.io/blog/velero-v1-1-stateful-backup-vsphere/)

## Installation

```sh
$ brew install velero
$ helm repo add vmware-tanzu https://vmware-tanzu.github.io/helm-charts
```

## Documentation

- [TFLint Rules](https://github.com/terraform-linters/tflint/tree/master/docs/rules)

## Usage example

Here's the gist of using it directly from github.

```hcl
    module "velero" {
    source  = "terraform-module/velero/kubernetes"
    version = "0.12.2"

    namespace_deploy            = true
    app_deploy                  = true
    cluster_name                = my-personal-cluster
    openid_connect_provider_uri = "openid-configuration"
    bucket                      = "backup-s3"
    values = [<<EOF
    # https://github.com/vmware-tanzu/helm-charts/tree/master/charts/velero

    image:
        repository: velero/velero
        tag: v1.4.2

    initContainers:
      - name: velero-plugin-for-aws
        image: velero/velero-plugin-for-aws:v1.1.0
        imagePullPolicy: IfNotPresent
        volumeMounts:
          - mountPath: /target
            name: plugins

    # SecurityContext to use for the Velero deployment. Optional.
    # Set fsGroup for `AWS IAM Roles for Service Accounts`
    # see more informations at: https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html
    securityContext:
        fsGroup: 1337

    configuration:
        provider: aws

        backupStorageLocation:
            name: default
            provider: aws
            bucket: backup-s3
            prefix: "velero/dev/my-cluster"
            config:
                region: eu-west-1

        volumeSnapshotLocation:
            name: default
            provider: aws
            # Additional provider-specific configuration. See link above
            # for details of required/optional fields for your provider.
            config:
                region: eu-west-1
    EOF
    ]
    vars  = {
        "version"       = "2.12.0"
    }
    tags = local.tags
    }
```

## Examples

See `examples` directory for working examples to reference

- [Examples TFM Dir](examples)

## Available features

- [X] Deploy `Velero`
- [X] Hook IAM role with `k8s Service Account` and `AWS WebIdentity`

## Module Variables

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.12.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.25.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/namespace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | A Release is an instance of a chart running in a Kubernetes cluster. | `map(any)` | `{}` | no |
| <a name="input_app_deploy"></a> [app\_deploy](#input\_app\_deploy) | Whether or not to deploy app | `bool` | `true` | no |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Backup and Restore bucket. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Namespace description | `string` | `"velero-back-up-and-restore"` | no |
| <a name="input_iam_deploy"></a> [iam\_deploy](#input\_iam\_deploy) | whther or not to deploy iam role | `bool` | `true` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Name of the Velero IAM role. If not specified a new iam role will be created  | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Installation name | `string` | `"velero"` | no |
| <a name="input_namespace_deploy"></a> [namespace\_deploy](#input\_namespace\_deploy) | Whether or not to deploy namespace | `bool` | `false` | no |
| <a name="input_namespace_name"></a> [namespace\_name](#input\_namespace\_name) | Kubernetes namespace name | `string` | `null` | no |
| <a name="input_openid_connect_provider_uri"></a> [openid\_connect\_provider\_uri](#input\_openid\_connect\_provider\_uri) | OpenID Connect Provider for EKS to enable IRSA. | `string` | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | VMware Tanzu repository for Helm repos. | `string` | `"https://vmware-tanzu.github.io/helm-charts"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the object. | `map(any)` | `{}` | no |
| <a name="input_values"></a> [values](#input\_values) | List of values in raw yaml to pass to helm. Values will be merged. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace_name"></a> [namespace\_name](#output\_namespace\_name) | Namespace name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Commands

<!-- START makefile-doc -->
```
$ make help
hooks                          Commit hooks setup
validate                       Validate with pre-commit hooks
changelog                      Update changelog
```
<!-- END makefile-doc -->

### :memo: Guidelines

- :memo: Use a succinct title and description.
- :bug: Bugs & feature requests can be be opened
- :signal_strength: Support questions are better asked on [Stack Overflow](https://stackoverflow.com/)
- :blush: Be nice, civil and polite ([as always](http://contributor-covenant.org/version/1/4/)).

## License

Copyright 2019 Ivan Katliarhcuk

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## How to Contribute

Submit a pull request

# Authors

Currently maintained by [Ivan Katliarchuk](https://github.com/ivankatliarchuk) and these [awesome contributors](https://github.com/terraform-module/terraform-kubernetes-velero/graphs/contributors).

[![ForTheBadge uses-git](http://ForTheBadge.com/images/badges/uses-git.svg)](https://GitHub.com/)

## Terraform Registry

- [Module](https://registry.terraform.io/modules/terraform-module/velero/kubernetes)

## TODO

- [ ] Kiam support
