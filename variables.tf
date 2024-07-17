variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "secrets" {
  description = "A list of secrets with their data"
  type = list(object({
    secret_id   = string
    secret_data = string
  }))
}

variable "secret_accessors" {
  description = "A map of service account emails to their respective roles"
  type = map(object({
    secret_id = string
    role      = string
  }))
  default = null
}