terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.16.0"
    }
  }
}

provider "google" {
  project     = var.google_project_id
  region      = var.region
}

resource "google_project_service" "cloudresource" {
  project = var.google_project_id
  service = "cloudresourcemanager.googleapis.com"
}