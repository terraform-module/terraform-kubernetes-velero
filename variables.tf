variable "cluster_name" {
  description = "Cluster name."
  type        = string
}

variable "namespace_deploy" {
  default     = false
  description = "Whether or not to deploy namespace"
  type        = bool
}

variable "app_deploy" {
  default     = true
  description = "Whether or not to deploy app"
  type        = bool
}

variable "iam_deploy" {
  default     = true
  description = "whther or not to deploy iam role"
  type        = bool
}

variable "name" {
  default     = "velero"
  description = "Installation name"
  type        = string
}

variable "namespace_name" {
  default     = null
  description = "Kubernetes namespace name"
  type        = string
}

variable "description" {
  default     = "velero-back-up-and-restore"
  description = "Namespace description"
  type        = string
}

variable "openid_connect_provider_uri" {
  description = "OpenID Connect Provider for EKS to enable IRSA."
  type        = string
}

variable "tags" {
  default     = {}
  description = "A mapping of tags to assign to the object."
  type        = map(any)
}

variable "repository" {
  default     = "https://vmware-tanzu.github.io/helm-charts"
  description = "VMware Tanzu repository for Helm repos."
  type        = string
}

variable "values" {
  description = "List of values in raw yaml to pass to helm. Values will be merged."
  type        = list(string)
}

variable "app" {
  description = "A Release is an instance of a chart running in a Kubernetes cluster."
  type        = map(any)
  default     = {}
}

variable "bucket" {
  description = "Backup and Restore bucket."
  type        = string
}

variable "iam_role_name" {
  description = "Name of the Velero IAM role"
  type        = string
  default     = ""
}

# Support to govcloud accounts
# https://docs.aws.amazon.com/govcloud-us/latest/UserGuide/using-govcloud-arns.html
variable "arn_preffix" {
  description = "Bucket arn preffix, usefull when You use govcloud accounts, for example: arn:aws-us-gov<*>"
  type        = string
  default     = "arn:aws"
}
