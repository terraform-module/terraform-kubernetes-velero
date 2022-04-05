resource "kubernetes_namespace" "this" {
  count = var.namespace_deploy ? 1 : 0

  metadata {
    name = local.namespace_name

    labels = {
      name        = local.namespace_name
      description = var.description
    }
  }
}

# Retrieving this data will ensure that the target Kubernetes namespace exists
# before proceeding.
data "kubernetes_namespace" "this" {
  metadata {
    name = local.namespace_name
  }

  depends_on = [
    kubernetes_namespace.this,
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
  version       = lookup(var.app, "version", "2.29.4")

  values = concat(
    var.values,
    local.additional_value,
  )
}
