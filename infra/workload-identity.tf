resource "google_iam_workload_identity_pool" "github" {
  workload_identity_pool_id = "github-brian2"
}

resource "google_iam_workload_identity_pool_provider" "github-automation" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-automation"
  display_name                       = "Demo App Provider"

  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }

  attribute_condition = "attribute.repository_owner == 'briananderson1222'"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

}