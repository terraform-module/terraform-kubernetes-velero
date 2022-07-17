data "aws_caller_identity" "this" {}

data "aws_eks_cluster" "this" {
  name = "my-cluster-name"
}

locals {
  openid_connect_provider_uri = replace(aws_iam_openid_connect_provider.this.url, "https://", "")
}

resource "aws_iam_openid_connect_provider" "this" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.this.certificates[0].sha1_fingerprin]
  url             = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

module "velero" {
  source  = "terraform-module/velero/kubernetes"
  version = "~> 1"

  count = 1

  namespace_deploy            = "velero"
  app_deploy                  = true
  cluster_name                = "my-cluster-name"
  openid_connect_provider_uri = local.openid_connect_provider_uri
  bucket                      = "my-cluster-name"
  app = {
    name          = "velero"
    version       = "2.29.4"
    chart         = "velero"
    force_update  = false
    wait          = true
    recreate_pods = true
    deploy        = false
    max_history   = 1
    image         = null
    tag           = null
  }
  tags = {}

  values = [<<EOF
# https://github.com/vmware-tanzu/helm-charts/tree/master/charts/velero

image:
  repository: velero/velero
  tag: v1.8.1

# https://aws.amazon.com/blogs/containers/backup-and-restore-your-amazon-eks-cluster-resources-using-velero/
# https://github.com/vmware-tanzu/velero-plugin-for-aws
initContainers:
  - name: velero-plugin-for-aws
    image: velero/velero-plugin-for-aws:v1.4.1
    imagePullPolicy: IfNotPresent
    volumeMounts:
      - mountPath: /target
        name: plugins

# Install CRDs as a templates. Enabled by default.
installCRDs: true

# SecurityContext to use for the Velero deployment. Optional.
# Set fsGroup for `AWS IAM Roles for Service Accounts`
# see more informations at: https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html
securityContext:
  fsGroup: 1337
  # fsGroup: 65534

##
## Parameters for the `default` BackupStorageLocation and VolumeSnapshotLocation,
## and additional server settings.
##
configuration:
  provider: aws

  backupStorageLocation:
    name: default
    provider: aws
    bucket: "velero-backups"
    prefix: "velero/sandbox/my-cluster-name"
    config:
      region: eu-west-1

  volumeSnapshotLocation:
    name: default
    provider: aws
    # Additional provider-specific configuration. See link above
    # for details of required/optional fields for your provider.
    config:
      region: eu-west-1

  # These are server-level settings passed as CLI flags to the `velero server` command. Velero
  # uses default values if they're not passed in, so they only need to be explicitly specified
  # here if using a non-default value. The `velero server` default values are shown in the
  # comments below.
  # --------------------
  # `velero server` default: 1m
  backupSyncPeriod:
  # `velero server` default: 1h
  resticTimeout:
  # `velero server` default: namespaces,persistentvolumes,persistentvolumeclaims,secrets,configmaps,serviceaccounts,limitranges,pods
  restoreResourcePriorities:
  # `velero server` default: false
  restoreOnlyMode:

  extraEnvVars:
    AWS_CLUSTER_NAME: my-cluster-name

  # Set log-level for Velero pod. Default: info. Other options: debug, warning, error, fatal, panic.
  logLevel: info

##
## End of backup/snapshot location settings.
##

##
## Settings for additional Velero resources.
##
rbac:
  create: true
  clusterAdministrator: true

credentials:
  # Whether a secret should be used as the source of IAM account
  # credentials. Set to false if, for example, using kube2iam or
  # kiam to provide IAM credentials for the Velero pod.
  useSecret: false

backupsEnabled: true
snapshotsEnabled: true
deployRestic: false
EOF
  ]
}
