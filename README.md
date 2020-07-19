# Velero installation on AWS EKS Kubernetes

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

## Assumptions

## Available features

## Module Variables

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| helm | >= 1.2 |
| kubernetes | >= 1.11.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| helm | >= 1.2 |
| kubernetes | >= 1.11.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_deploy | whther or not to deploy app | `bool` | `true` | no |
| bucket | Backup and Restore bucket. | `string` | n/a | yes |
| cluster\_name | Cluster name. | `string` | n/a | yes |
| description | Namespace description | `string` | `"velero-back-up-and-restore"` | no |
| name | namespace name | `string` | `"velero"` | no |
| namespace\_deploy | whther or not to deploy namespace | `bool` | `false` | no |
| openid\_connect\_provider\_uri | OpenID Connect Provider for EKS to enable IRSA. | `string` | n/a | yes |
| repository | VMware Tanzu repository for Helm repos. | `string` | `"https://vmware-tanzu.github.io/helm-charts"` | no |
| tags | A mapping of tags to assign to the object. | `map` | `{}` | no |
| values | List of values in raw yaml to pass to helm. Values will be merged. | `list(string)` | n/a | yes |
| vars | A Release is an instance of a chart running in a Kubernetes cluster. | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| namespace | Namespace name |
| namespace\_name | Namespace name |

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

- [Module](https://registry.terraform.io/modules/terraform-module/kubernetes-velero/aws)

## TODO

- [ ] Kiam support
