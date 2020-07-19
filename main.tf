resource kubernetes_namespace this {
  count = var.namespace_deploy ? 1 : 0

  metadata {
    name = var.name

    labels = {
      name        = var.name
      description = var.description
    }
  }
}

resource helm_release this {
  count = var.app_deploy ? 1 : 0

  name       = var.name
  chart      = var.name
  namespace  = local.namespace
  repository = var.repository

  force_update  = lookup(var.vars, "force_update", true)
  wait          = lookup(var.vars, "wait", true)
  recreate_pods = lookup(var.vars, "recreate_pods", true)
  max_history   = lookup(var.vars, "max_history", 0)
  lint          = lookup(var.vars, "lint", true)
  version       = lookup(var.vars, "version", "2.12.0")

  values = concat(var.values, list(<<EOF
serviceAccount:
  server:
    create: true
    annotations:
      eks.amazonaws.com/role-arn: "${aws_iam_role.this.arn}"
EOF
  ))
}
