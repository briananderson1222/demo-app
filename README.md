# demo-app

# Getting Started

## Steps taken to setup repo:
1. Create new public repo in GitHub 
2. Generate SpringBoot project using [Spring Initializr](https://start.spring.io/) w/ Spring Web and Actuator
3. Commit and push to repo

## Run this project yourself!

### Setup Sonarcloud Integration
1. Setup new Organization and Project in [SonarCloud](https://sonarcloud.io/)
2. Add `SONAR_TOKEN` to Settings > Secrets > Actions
3. Modify `build.gradle` with your Sonar properties

### Create Terraform Cloud Workspace
1. Visit [Terraform Cloud](https://app.terraform.io) and setup workspace
2. Update `infra/main.tf` to include workspace name
3. Add `TF_TOKEN` to Settings > Actions > Secrets

### Setup New Google Project
1. Visit the [Google Cloud Console](https://console.cloud.google.com/)
2. Create new GCP Project

### Provision Infrastructure for Application (Artifact Repository, Autopilot Cluster & Workload Identity)
1. Navigate to the ["Demo Infrastructure Pipeline" and "Run Workload"](https://github.com/briananderson1222/demo-app/actions/workflows/terraform.yml)
    1. ~~Provide GCP Project ID created above~~ -- GCP Project ID has to be modified in the `.github/workflows/terraform.yml` manually for now

### Configure Container Image
1. Open `manifest.yaml` and modify the Deployment's image path replacing `brian-dev-1222` with the GCP Project ID created above

### Deploy the Application
1. Navigate to the ["Demo CI Pipeline" and "Run Workload"](https://github.com/briananderson1222/demo-app/actions/workflows/ci.yml)
    1. ~~Provide GCP Project ID & Number created above~~ -- GCP Project ID & Number has to be modified in the `.github/workflows/ci.yml` and `.github/workflows/cd.yml` manually for now

## Things to enhance with more time
### Infrastructure
- Use something like 'helm' for managing kubernetes resources
- More separation of concerns
    - Separate projects/clusters for dev/prod 
    - Use terraform workspaces (where it makes sense)
    - Separate repo for managing `infra` folder (Terraform)
- Use OIDC for Terraform Cloud integration

**NOTE**:
  - There's an order of operations that depends on the infrastructure provisioning patterns within the organization. It is possible that a project team would maintain their own cluster and that would likely be handled outside of specific application repository OR a dedicated infrastructure team would have a pattern for a multi-tenant cluster which would involve provisioning namespaces for a team and handing off access to either the application team or some dedicated pipeline process that can source the information it needs from a secure place like Vault.

### Application
- Move common GitHub Actions to a separate repo so they can be versioned and shared across multiple applications. ALSO, so that every stage doesn't require the 'checkout' step.
- Add inputs to workflow dispatch to remove hardcoding for my project
- Integration with a key management system like Vault
- Don't use "latest" tag for deployment
- Concept captured by "Analyze" & "Publish" stages:
    - Integration with NexusIQ & Container Scanning tools for vulnerabilities
- The "Build & Test" stage captures this idea, but on top of unit tests w/ jacoco coverage I would:
    - Add robust unit testing using mutation testing to measure test strength
    - Add robust integration & performance tests

## Things that made things take a bit longer (Challenges)
- I hadn't done development on a Windows computer in quite some time. Most things that I had setup in the past were severely outdated and actually made things harder to get going (had to uninstall and reinstall in certain cases and couldn't only focus on creating the pipeline/infrastructure as I didn't have a proper development environment setup). This also had me experimenting with Codespaces and configuring "dev containers" which was not something I had done before.
- GitHub Actions was brand new to me and while many concepts are familiar to me having worked with GitLab there are lots of subtle syntactical gotchas that I had to work through.
     - I will admit that I poked around with ChatGPT on this front to try to help things move quicker (also a first for me as most clients I've worked with so far don't allow public GPTs and do not have any of their own setup yet). I think "trying to move faster" in this case actually ended up slowing me down because GPT was offering advice and code that looked logical, but was incorrect and also referenced experimental features without the context of documentation or code that was known to be already working.
- I had not worked with OpenID Connect (OIDC) before as it's been over a year and a half since I was working with automation in a way where I had to configure auth for various tasks.. This was suggested in the docs for the google-auth github action and I remembered two years back (2022) that passing around credential files was supposed to soon be a thing of the past. This was intriguing as it allowed me to not require the manual step of uploading credentials between provisioning the infrastructure and providing a service account (w/ least privilege) to be used by the Application's CI/CD Pipeline  
