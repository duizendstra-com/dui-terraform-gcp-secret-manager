output "secret_ids" {
  description = "The IDs of the created secrets"
  value       = { for k, v in google_secret_manager_secret.main : k => v.id }
}

output "secret_versions" {
  description = "The versions of the created secrets"
  value       = { for k, v in google_secret_manager_secret_version.main : k => v.id }
}

