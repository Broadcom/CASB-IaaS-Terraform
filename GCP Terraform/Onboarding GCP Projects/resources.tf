//Google Cloud provider
provider "google" {
  project = var.gcp_project
  region  = var.region
}

// Create Cloud Soc Role
resource "google_project_iam_custom_role" "createCustomRole" {
  role_id     = "${var.cloudSocTenantId}_role"
  title       = "${var.cloudSocDataCollectionRoleTitle}-${var.cloudSocTenantId}"
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
  name = "${var.cloudSocTenantId}-topic"

}

//PubsubSubscription
resource "google_pubsub_subscription" "createPubSubSubscription" {
  name  = "${var.cloudSocTenantId}-subscription"
  topic = google_pubsub_topic.createLogSinkPubSubTopics.id

  push_config {
    push_endpoint = "${var.cloudSocWebhookUrl}?connection_id=${var.cloudSocConnectionId}&token=${var.cloudSocPerpetualToken}"

  }
}

//log-sink
resource "google_logging_project_sink" "createLogSink" {
  name        = "${var.cloudSocTenantId}-sink"
  destination = "pubsub.googleapis.com/${google_pubsub_topic.createLogSinkPubSubTopics.id}"
  filter      = var.logSinkFilter
  description = var.logSinkDescription
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
resource "google_project_iam_member" "assignRolesToServiceAccount" {
  project = var.gcp_project
  role    = "projects/${var.gcp_project}/roles/${var.cloudSocTenantId}_role"
  member  = "serviceAccount:${var.cloudSocTenantId}@${var.gcp_project}.iam.gserviceaccount.com"
}

//PubsubTopic Binding
resource "google_pubsub_topic_iam_binding" "binding" {
  project = var.gcp_project
  topic   = google_pubsub_topic.createLogSinkPubSubTopics.id
  role    = "roles/pubsub.publisher"
  members = [
    google_logging_project_sink.createLogSink.writer_identity
  ]
}