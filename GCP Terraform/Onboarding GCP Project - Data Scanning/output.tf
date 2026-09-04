
output "ServiceAccountID" {
  description = "Service Account ID"
  value       = "${var.cloudSocTenantId}@${var.gcp_project}.iam.gserviceaccount.com"
}


