# demo-app

# Getting Started

## Pre-requisites
1. Ensure the `gcloud` cli is installed 
    1. https://cloud.google.com/sdk/docs/install
2. Ensure the `kubectl` cli and `gke-gcloud-auth-plugin` are installed (only needed for cluster authentication and namespace creation)
    1. `gcloud components install kubectl`
    2. `gcloud components install gke-gcloud-auth-plugin`

## Steps taken to setup repo:
1. Create new public repo in GitHub 
2. Generate SpringBoot project using Spring Initializr w/ Spring Web and Actuator
3. Commit and push to repo
4. Setup new Organization and Project in [SonarCloud](https://sonarcloud.io/)
5. Add `SONAR_TOKEN` to Settings > Secrets > Actions
6. Add gradle dependency and sonar properties to project

## Steps to run

### Setup New Google Project & Credentials
1. Define a project id 
    1. `export GCP_PROJECT_ID=demo-project`
2. `gcloud projects create ${GCP_PROJECT_ID}`
3. `gcloud auth application-default login` and follow directions to setup gcloud cli credentials

### Provision Infrastructure for Application (Artifact Repository & Autopilot Cluster)
1. Navigate to terraform directory
    1. `cd infra`
2. Initialize terraform providers
    1. `terraform init`
3. Apply terraform by setting the `google_project_id` (from section: "Setup New Google Project & Credentials") and auto-approving the plan.
    1. `TF_VARS_google_project_id=${GCP_PROJECT_ID} terraform apply -auto-approve`
        1. This will take 5-10 minutes to stand up the cluster
4. Create `development` and `production` namespaces to be used for example purposes by the application pipeline.
    1. `gcloud container clusters get-credentials autopilot-cluster-1 --region us-central1 --project ${GCP_PROJECT_ID}`
    2. `kubectl create namespace development`
    3. `kubectl create namespace production`

### Configure Pipeline 
1. Setup pipeline workflow to use the newly created project
    1. Open `.github/workflows/pipeline.yaml` and modify `env.GCP_PROJECT_ID` (line 14) to the value of $GCP_PROJECT_ID (from section: "Setup New Google Project & Credentials")
    2. Open `manifest.yaml` and modify the Deployment's image path replacing `brian-dev-1222` with $GCP_PROJECT_ID
2. Create a Service Account Credentials File for use by the pipeline
    1. Navigate to https://console.cloud.google.com/iam-admin/serviceaccounts?project=<GCP_PROJECT_ID> -- replacing GCP_PROJECT_ID with your project name
    2. Click the triple dot menu for `pipeline@<GCP_PROJECT_ID>.iam.gserviceaccount.com` and click "Manage Keys"
        1. The `pipeline` service account was created by the `terraform apply` to demonstrate principles around 'least-privilege'
    3. Create/Download a new "JSON" format credentials file
3. Add Credentials File as a GitHub Secret
    1. Add `GCP_CREDENTIALS` secret to GitHub under Settings > Secrets > Actions with the contents of the credentials file.

### Run the Pipeline
1. Kick off pipeline!

## Things to enhance with more time
### Infrastructure
- Automatically generate key credentials and upload secret to GitHub 
- Automatically provision namespace 
- Use something like 'helm' for managing kubernetes resources
- More separation of concerns
    - Separate projects/clusters for dev/prod 
    - Use terraform workspaces (where it makes sense)
    - Separate repo for managing `infra` folder (Terraform)
- Create terraform pipeline
- Remote state files

**NOTE**:
  - There's an order of operations that depends on the infrastructure provisioning patterns within the organization. It is possible that a project team would maintain their own cluster and that would likely be handled outside of specific application repository OR a dedicated infrastructure team would have a pattern for a multi-tenant cluster which would involve provisioning namespaces for a team and handing off access to either the application team or some dedicated pipeline process that can source the information it needs from a secure place like Vault.

### Application
- Move common GitHub Actions to a separate repo so they can be versioned and shared across multiple applications. ALSO, so that every stage doesn't require the 'checkout' step.
- Integration with a key management system like Vault
- Concept captured by "Analyze" & "Publish" stages:
    - Integration with NexusIQ & Container Scanning tools for vulnerabilities
- The "Build & Test" stage captures this idea, but on top of unit tests w/ jacoco coverage I would:
    - Add robust unit testing using mutation testing to measure test strength
    - Add robust integration & performance tests

## Things that made things take a bit longer (Challenges)
- I hadn't done development on a Windows computer in quite some time. Most things that I had setup in the past were severely outdated and actually made things harder to get going (had to uninstall and reinstall in certain cases and couldn't only focus on creating the pipeline/infrastructure as I didn't have a proper development environment setup)
- GitHub Actions was brand new to me and while many concepts are familiar to me having worked with GitLab there are lots of subtle syntactical gotchas that I had to work through.
     - I will admit that I poked around with ChatGPT on this front to try to help things move quicker (also a first for me as most clients I've worked with so far don't allow public GPTs and do not have any of their own setup yet). I think "trying to move faster" in this case actually ended up slowing me down because GPT was offering advice and code that was incorrect and also referencing experimental features without the context of documentation or code that was known to be already working.
