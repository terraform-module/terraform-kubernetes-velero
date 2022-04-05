locals {
  namespace_name = coalesce(var.namespace_name, var.name)
  namespace      = data.kubernetes_namespace.this.metadata[0].name
  account_id     = data.aws_caller_identity.current.account_id

  additional_value = var.iam_deploy ? tolist([
    templatefile("${path.module}/value_templates/serviceaccount.template.yaml", {
      EKS_ROLE_ARN = aws_iam_role.this[0].arn
    }),
  ]) : []
}
