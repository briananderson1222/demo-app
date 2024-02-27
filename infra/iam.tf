locals {
  gke_roles = toset([
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
    "roles/autoscaling.metricsWriter"
  ])
}


resource "google_service_account" "cicd" {
  account_id   = "pipeline"
  display_name = "CI/CD Service Account"
}

resource "google_service_account" "cluster" {
  account_id   = "cluster"
  display_name = "Service Account for operating GKE with minimum permissions"
}

resource "google_artifact_registry_repository_iam_member" "cicd" {
  location   = google_artifact_registry_repository.artifact-repo.location
  repository = google_artifact_registry_repository.artifact-repo.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.cicd.email}"
}

resource "google_service_account_iam_member" "cicd-workload-identity" {
  service_account_id = google_service_account.cicd.name

  role   = "roles/iam.workloadIdentityUser"
  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository_owner/briananderson1222"
}

resource "google_project_iam_member" "cicd-container-developer" {
  depends_on = [google_project_service.cloudresource] # For demo purposes
  project    = var.google_project_id

  role   = "roles/container.developer"
  member = "serviceAccount:${google_service_account.cicd.email}"
}

resource "google_artifact_registry_repository_iam_member" "cluster" {
  location   = google_artifact_registry_repository.artifact-repo.location
  repository = google_artifact_registry_repository.artifact-repo.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.cluster.email}"
}

resource "google_project_iam_binding" "cluster-roles" {
  depends_on = [google_project_service.cloudresource] # For demo purposes
  for_each   = local.gke_roles
  project    = var.google_project_id
  role       = each.value

  members = [
    "serviceAccount:${google_service_account.cluster.email}"
  ]
}