locals {
  namespace  = data.kubernetes_namespace.this.metadata.0.name
  account_id = data.aws_caller_identity.current.account_id
}
