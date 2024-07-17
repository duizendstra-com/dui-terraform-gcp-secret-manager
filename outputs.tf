output "secret_ids" {
  description = "The IDs of the created secrets"
  value = { for key, secret in google_secret_manager_secret.main : key => secret.id }
}

output "secret_versions" {
  description = "The versions of the created secrets"
  value = { for key, version in google_secret_manager_secret_version.main : key => version.id }
}


