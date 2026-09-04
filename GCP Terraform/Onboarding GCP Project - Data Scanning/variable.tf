variable "gcp_project" {
  description = "Enter the GCP Project ID"
  type        = string
  default     = "<gcp_project_id>"
}

variable "region" {
  description = "Enter the GCP Project Region"
  type        = string
  default     = "<region>"
}


// Please Update the below variable from the CloudSoc GCP Script Downloaded from the connection
variable "cloudSocTenantId" {
  description = "Enter the cloudSocTenantId from the CloudSoc GCP Script Downloaded from the connection"
  type        = string
  default     = "<cloudSocTenantId>"
}

variable "broadcomScanAccount" {
  description = "Enter the broadcomScanAccount from the CloudSoc GCP Script Downloaded from the connection"
  type        = string
  default     = "<broadcomScanAccount>"
}


//Below variables can work with default value
variable "serviceAccountDisplayName" {
  description = "The is GCP Service Account Display Name"
  type        = string
  default     = "CloudSoc Scan Account"
}

variable "serviceAccountDescription" {
  description = "The is GCP Service Account Description"
  type        = string
  default     = "CloudSoc Scan Account"
}

variable "cloudSocDataCollectionRoleTitle" {
  description = "The is Cloud Soc Data Collection Role Title"
  type        = string
  default     = "CloudSoc Data Collection Role"
}

variable "cloudSocDataCollectionRoleDescription" {
  description = "The is Cloud Soc Data Collection Role Description"
  type        = string
  default     = "CloudSoc Data Collection Role"
}

// Below should not be edited updated as these are recommended list of permissions, services and filter required for cloud soc to work.
variable "cloudSocDataCollectionRolePermissions" {
  description = "The list of cloudSoc Data Collection Role Permissions Required"
  type        = list(string)
  default = [
    "monitoring.timeSeries.list", "resourcemanager.projects.get", "resourcemanager.projects.getIamPolicy", "storage.buckets.get",
    "storage.buckets.list", "storage.objects.get", "storage.objects.list", "storage.objects.getIamPolicy", "storage.buckets.getIamPolicy"
  ]
}

// "pubsub.googleapis.com" and "logging.googleapis.com" are only required for the Pub/Sub topic/subscription and log sink (notifications). Remove them from this list if notifications are not required.
variable "gcp_service_list" {
  description = "The list of API required to be enabled"
  type        = list(string)
  default = [
    "iam.googleapis.com", "cloudresourcemanager.googleapis.com", "storage-component.googleapis.com", "pubsub.googleapis.com", "logging.googleapis.com"
  ]

}

// ---------------------------------------------------------------------------
// Below variables are only required for notifications (Pub/Sub topic/subscription and log sink).
// Comment all of them out together if notifications are not required.
// ---------------------------------------------------------------------------

// Please Update the below variable from the CloudSoc GCP Script Downloaded from the connection
variable "cloudSocConnectionId" {
  description = "Enter the cloudSocConnectionId from the CloudSoc GCP Script Downloaded from the connection"
  type        = string
  default     = "<cloudSocConnectionId>"
}

variable "cloudSocWebhookUrl" {
  description = "Enter the cloudSocWebhookUrl from the CloudSoc GCP Script Downloaded from the connection"
  type        = string
  default     = "<cloudSocWebhookUrl>"
}

variable "cloudSocPerpetualToken" {
  description = "Enter the cloudSocPerpetualToken from the CloudSoc GCP Script Downloaded from the connection"
  type        = string
  default     = "<cloudSocPerpetualToken>"
}

variable "logSinkDescription" {
  description = "The is GCP Log Sink Description"
  type        = string
  default     = "CloudSoc Log Sink"
}

variable "logSinkFilter" {
  description = "This is filter for log router sink"
  type        = string
  default     = "(((LOG_ID(cloudaudit.googleapis.com/activity) OR LOG_ID(externalaudit.googleapis.com/activity)) AND (protoPayload.serviceName=storage.googleapis.com AND (protoPayload.methodName=storage.buckets.create OR protoPayload.methodName=storage.buckets.delete OR protoPayload.methodName=storage.buckets.update OR protoPayload.methodName=storage.setIamPermissions))) OR (protoPayload.methodName = storage.objects.create OR protoPayload.methodName = storage.objects.delete OR protoPayload.methodName = storage.objects.update)) AND (severity=INFO OR severity=NOTICE)"

}
