variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "secrets" {
  description = "A list of secrets with their data and accessors"
  type = list(object({
    secret_id     = string
    secret_data   = string
    accessors     = list(object({
      email = string
      role  = string
    }))
  }))
}
