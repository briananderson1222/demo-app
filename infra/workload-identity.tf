resource "google_iam_workload_identity_pool" "automation" {
  workload_identity_pool_id = "github"
}

resource "google_iam_workload_identity_pool_provider" "github-automation" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.automation.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-automation"
  display_name                       = "Demo App Provider"

  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }

  attribute_condition = "'briananderson1222' in attribute.repository_owner"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

}