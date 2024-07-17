resource "google_project_service" "main" {
  project            = var.project_id
  service            = "secretmanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_secret_manager_secret" "main" {
  for_each = { for s in var.secrets : s.secret_id => s }

  project   = var.project_id
  secret_id = each.value.secret_id

  replication {
    auto {}
  }

  depends_on = [
    google_project_service.main
  ]
}

resource "google_secret_manager_secret_version" "main" {
  for_each   = { for s in var.secrets : s.secret_id => s }
  secret     = google_secret_manager_secret.main[each.key].id
  secret_data = each.value.secret_data

  depends_on = [
    google_secret_manager_secret.main
  ]
}

locals {
  secret_accessors = flatten([
    for secret in var.secrets : [
      for accessor in secret.accessors : {
        secret_id = secret.secret_id
        role      = accessor.role
        email     = accessor.email
      }
    ]
  ])
}

resource "google_secret_manager_secret_iam_member" "access_secret" {
  for_each = { for accessor in local.secret_accessors : "${accessor.secret_id}:${accessor.email}" => accessor }

  secret_id = google_secret_manager_secret.main[each.value.secret_id].id
  role      = each.value.role
  member    = "serviceAccount:${each.value.email}"
}


