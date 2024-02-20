resource "google_artifact_registry_repository" "artifact-repo" {
  location      = var.region
  repository_id = var.registry-name
  description   = "Image repository for storing images to be deployed"
  format        = "DOCKER"
}