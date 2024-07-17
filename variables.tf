variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "secrets" {
  description = "A map of secrets with their data"
  type = map(object({
    secret_id   = string
    secret_data = string
  }))
}
