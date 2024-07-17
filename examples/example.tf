terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.38.0"
    }
  }
}

provider "google" {
  project = "your-project-id"
}

module "secret_manager" {
  source      = "./.."
  project_id  = "your-project-id"
  secrets     = [
  {
    secret_id   = "your-secret-id-01"
    secret_data = "your-secret-data"
    accessors = [
      {
        email = "youre-email-address"
        role  = "roles/secretmanager.secretAccessor"
      }
    ]
  },
  {
    secret_id   = "your-secret-id-02"
    secret_data = "your-secret-data"
    accessors = [
      {
        email = "youre-email-address"
        role  = "roles/secretmanager.secretAccessor"
      }
    ]
  }
 ]
}