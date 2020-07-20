variable "cluster_name" {
  description = "Cluster name."
  type        = string
}

variable "namespace_deploy" {
  default     = false
  description = "whther or not to deploy namespace"
  type        = bool
}

variable "app_deploy" {
  default     = true
  description = "whther or not to deploy app"
  type        = bool
}

variable "name" {
  default     = "velero"
  description = "namespace name"
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
  type        = map
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
  type        = map
  default     = {}
}

variable "bucket" {
  description = "Backup and Restore bucket."
  type        = string
}
