variable "google_project_id" {
  type    = string
  default = "brian-dev-1222" # For demo purposes
}

variable "region" {
  default     = "us-central1"
  type        = string
  description = "Region used for creating resources"
}

variable "registry-name" {
  default     = "container-registry"
  type        = string
  description = "Name of artifact registry used for storing images"
}

variable "cluster-name" {
  default     = "autopilot-cluster-1"
  type        = string
  description = "Name of the K8s cluster to create"
}