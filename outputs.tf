output "namespace" {
  value       = kubernetes_namespace.this[0].metadata[0].name
  description = "Namespace name"
}

output "namespace_name" {
  value       = local.namespace
  description = "Namespace name"
}
