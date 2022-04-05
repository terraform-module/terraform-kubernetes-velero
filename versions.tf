terraform {
  required_version = ">= 1"

  required_providers {
    aws        = ">= 4"
    helm       = ">= 1.2"
    kubernetes = ">= 2"
  }
}
