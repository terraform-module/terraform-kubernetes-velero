terraform {
  required_version = "~> 1"

  required_providers {
    aws = {
      version = ">= 4"
      source  = "hashicorp/aws"
    }
    helm = {
      version = "~> 2"
      source  = "hashicorp/helm"
    }
    kubernetes = {
      version = "~> 2"
      source  = "hashicorp/kubernetes"
    }
  }
}
