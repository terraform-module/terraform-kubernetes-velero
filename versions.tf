terraform {
  required_version = ">= 0.12"

  required_providers {
    aws        = ">= 3.0"
    helm       = ">= 1.2"
    kubernetes = ">= 1.11.0"
  }
}
