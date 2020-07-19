terraform {
  required_version = ">= 0.12"

  required_providers {
    kubernetes = ">= 1.11.0"
    helm       = ">= 1.2"
  }
}
