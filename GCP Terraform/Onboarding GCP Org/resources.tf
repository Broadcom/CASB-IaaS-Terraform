//Google Cloud provider
provider "google" {
  project = var.gcp_project
  region  = var.region
}

// Create Cloud Soc Role 
resource "google_organization_iam_custom_role" "createCustomRole" {
  role_id     = "${var.cloudSocTenantId}_${var.gcp_org_id}_role"
  title       = "${var.cloudSocDataCollectionRoleTitle}-${var.cloudSocTenantId}"
  org_id      = var.gcp_org_id
  description = var.cloudSocDataCollectionRoleDescription
  permissions = var.cloudSocDataCollectionRolePermissions
}

// Create Service Account
resource "google_service_account" "createServiceAccount" {
  account_id   = var.cloudSocTenantId
  display_name = var.serviceAccountDisplayName
  description  = var.serviceAccountDescription
}

//EnableAPIServices needed for Cloud Soc
resource "google_project_service" "enableAPIService" {
  for_each = toset(var.gcp_service_list)
  project  = var.gcp_project
  service  = each.key
}

//PubsubTopic
resource "google_pubsub_topic" "createLogSinkPubSubTopics" {
  name = "${var.cloudSocTenantId}-${var.gcp_org_id}-topic"

}

//PubsubSubscription
resource "google_pubsub_subscription" "createPubSubSubscription" {
  name  = "${var.cloudSocTenantId}-${var.gcp_org_id}-subscription"
  topic = google_pubsub_topic.createLogSinkPubSubTopics.id
  expiration_policy {
    ttl = ""
  }
  push_config {
    push_endpoint = "${var.cloudSocWebhookUrl}?connection_id=${var.cloudSocConnectionId}&token=${var.cloudSocPerpetualToken}"

  }
}

//log-sink
resource "google_logging_organization_sink" "createLogSink" {
  name             = "${var.cloudSocTenantId}-${var.gcp_org_id}-sink"
  destination      = "pubsub.googleapis.com/${google_pubsub_topic.createLogSinkPubSubTopics.id}"
  filter           = var.logSinkFilter
  description      = var.logSinkDescription
  org_id           = var.gcp_org_id
  include_children = true
}

//Assign User Access to ServiceAccount 
resource "google_service_account_iam_binding" "assignUsersAccessToServiceAccount" {
  service_account_id = google_service_account.createServiceAccount.name
  role               = "roles/iam.serviceAccountTokenCreator"

  members = [
    "serviceAccount:${var.broadcomScanAccount}"
  ]
}

//Assign Cloud Soc Role to ServiceAccount 
resource "google_organization_iam_binding" "assignRolesToServiceAccount" {
  org_id = var.gcp_org_id
  role   = "organizations/${var.gcp_org_id}/roles/${var.cloudSocTenantId}_${var.gcp_org_id}_role"

  members = [
    "serviceAccount:${var.cloudSocTenantId}@${var.gcp_project}.iam.gserviceaccount.com"
  ]
}

//PubsubTopic Binding
resource "google_pubsub_topic_iam_binding" "bindingTopicToWriterIdentity" {
  project = var.gcp_project
  topic   = google_pubsub_topic.createLogSinkPubSubTopics.id
  role    = "roles/pubsub.publisher"
  members = [
    google_logging_organization_sink.createLogSink.writer_identity
  ]
}