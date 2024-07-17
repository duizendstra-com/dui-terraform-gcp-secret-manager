terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.38.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

resource "google_secret_manager_secret" "main" {
  for_each = var.secrets

  project   = var.project_id
  secret_id = each.value.secret_id

  replication {
    automatic {}
  }
}

resource "google_secret_manager_secret_version" "main" {
  for_each   = var.secrets
  secret     = google_secret_manager_secret.main[each.key].id
  secret_data = each.value.secret_data
}

resource "google_secret_manager_secret_iam_member" "access_secret_version" {
  for_each = var.secret_accessors != null ? var.secret_accessors : {}

  secret_id = google_secret_manager_secret.main[each.value.secret_id].id
  role      = each.value.role
  member    = "serviceAccount:${each.key}"
}
