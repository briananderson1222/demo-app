terraform {
  cloud {
    organization = "briananderson-xyz"

    workspaces {
      name = "brian-dev-1222"
    }
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.16.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.26.0"
    }
  }
}

provider "google" {
  project = var.google_project_id
  region  = var.region
}

data "google_client_config" "current" {}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
  token                  = data.google_client_config.current.access_token
}

# enable IAM Binding (if not controlled by process that creates project)
resource "google_project_service" "cloudresource" {
  project = var.google_project_id
  service = "cloudresourcemanager.googleapis.com"
}