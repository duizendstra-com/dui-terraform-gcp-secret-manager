terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.32.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

resource "google_project_service" "main" {
  project            = var.project_id
  service            = "secretmanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_secret_manager_secret" "main" {
  for_each = var.secrets

  project   = var.project_id
  secret_id = each.value.secret_id

  replication {
    auto {}
  }

  depends_on = [google_project_service.main]
}

resource "google_secret_manager_secret_version" "main" {
  for_each    = var.secrets

  secret      = google_secret_manager_secret.main[each.key].id
  secret_data = each.value.secret_data

  depends_on = [google_secret_manager_secret.main]
}
