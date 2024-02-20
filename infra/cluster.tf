resource "google_container_cluster" "primary" {
  deletion_protection = false # For demo purposes

  name     = var.cluster-name
  location = var.region

  enable_autopilot = true

  cluster_autoscaling {
    auto_provisioning_defaults {
      service_account = google_service_account.cluster.email
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
    }
  }
}
