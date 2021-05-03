resource "kubernetes_namespace" "this" {
  count = var.namespace_deploy ? 1 : 0

  metadata {
    name = var.name

    labels = {
      name        = var.name
      description = var.description
    }
  }
}

data "kubernetes_namespace" "this" {
  metadata {
    name = var.name
  }

  depends_on = [
    kubernetes_namespace.this
  ]
}

resource "helm_release" "this" {
  count = var.app_deploy ? 1 : 0

  name       = var.name
  chart      = var.name
  namespace  = local.namespace
  repository = var.repository

  force_update  = lookup(var.app, "force_update", true)
  wait          = lookup(var.app, "wait", true)
  recreate_pods = lookup(var.app, "recreate_pods", true)
  max_history   = lookup(var.app, "max_history", 1)
  lint          = lookup(var.app, "lint", true)
  version       = lookup(var.app, "version", "2.13.2")

  values = concat(
    var.values,
    tolist([
      templatefile("${path.module}/value_templates/serviceaccount.template.yaml", {
        EKS_ROLE_ARN = aws_iam_role.this[0].arn
      }),
    ]),
  )
}
