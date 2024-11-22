variable "gcp_project" {
  description = "Enter the GCP Project ID"
  type        = string
  default     = "<gcp_project_id>>"
}

variable "gcp_org_id" {
  description = "Enter the GCP Org ID"
  type        = string
  default     = "<gcp_org_id>>"
}

variable "region" {
  description = "Enter the GCP Project Region"
  type        = string
  default     = "<region>"
}


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

variable "logSinkDescription" {
  description = "The is GCP Log Sink Description"
  type        = string
  default     = "CloudSoc Log Sink"
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
    "storage.buckets.list", "storage.objects.get", "storage.objects.list", "storage.objects.getIamPolicy", "storage.buckets.getIamPolicy",
    "apikeys.keys.get", "apikeys.keys.list", "cloudsql.instances.get", "cloudsql.instances.list", "compute.zones.list",
    "compute.disks.get", "compute.disks.list", "compute.instances.get", "compute.instances.list", "bigquery.datasets.get",
    "dns.managedZones.get", "dns.managedZones.list", "logging.logMetrics.get", "logging.logMetrics.list", "logging.sinks.get",
    "logging.sinks.list", "cloudkms.cryptoKeys.get", "cloudkms.cryptoKeys.list", "cloudkms.keyRings.get", "cloudkms.keyRings.list",
    "cloudkms.cryptoKeys.getIamPolicy", "compute.networks.get", "compute.networks.list", "monitoring.alertPolicies.get",
    "monitoring.alertPolicies.list", "compute.subnetworks.get", "compute.subnetworks.list", "compute.urlMaps.get",
    "compute.urlMaps.list", "compute.backendServices.get", "compute.backendServices.list", "bigquery.datasets.getIamPolicy",
    "compute.regionBackendServices.get", "compute.regionBackendServices.list", "compute.regionUrlMaps.get", "compute.regionUrlMaps.list",
    "essentialcontacts.contacts.get", "essentialcontacts.contacts.list", "bigquery.tables.list", "bigquery.tables.get",
    "dns.policies.get", "dns.policies.list", "compute.firewalls.get", "compute.firewalls.list", "cloudasset.assets.searchAllResources",
    "iam.serviceAccountKeys.list", "accessapproval.settings.get", "compute.regions.list", "dataproc.clusters.list", "dataproc.clusters.get",
    "bigquery.readsessions.create", "bigquery.readsessions.getData", "bigquery.tables.getData",
    "aiplatform.models.get", "aiplatform.models.list", "aiplatform.datasets.get", "aiplatform.datasets.list",
    "aiplatform.endpoints.get", "aiplatform.endpoints.list", "bigquery.tables.getIamPolicy", "resourcemanager.folders.get",
    "resourcemanager.folders.getIamPolicy", "resourcemanager.folders.list", "resourcemanager.organizations.get",
    "resourcemanager.organizations.getIamPolicy", "resourcemanager.projects.list"
  ]
}

variable "gcp_service_list" {
  description = "The list of API required to be enabled"
  type        = list(string)
  default = [
    "iam.googleapis.com", "cloudresourcemanager.googleapis.com", "storage-component.googleapis.com", "pubsub.googleapis.com", "logging.googleapis.com",
    "apikeys.googleapis.com", "sqladmin.googleapis.com", "compute.googleapis.com", "bigquery.googleapis.com", "dns.googleapis.com",
    "cloudkms.googleapis.com", "essentialcontacts.googleapis.com", "cloudasset.googleapis.com", "accessapproval.googleapis.com",
    "dataproc.googleapis.com", "aiplatform.googleapis.com"
  ]

}

variable "logSinkFilter" {
  description = "This is filter for log router sink"
  type        = string
  default     = "(((LOG_ID(cloudaudit.googleapis.com/activity) OR LOG_ID(externalaudit.googleapis.com/activity)) AND ((protoPayload.serviceName=compute.googleapis.com) OR (protoPayload.serviceName=bigquery.googleapis.com) OR (protoPayload.serviceName=storage.googleapis.com) OR (protoPayload.serviceName=iam.googleapis.com) OR (protoPayload.serviceName=logging.googleapis.com) OR (protoPayload.serviceName=cloudkms.googleapis.com) OR (protoPayload.serviceName=cloudsql.googleapis.com) OR (protoPayload.serviceName=dns.googleapis.com) OR (protoPayload.serviceName=accessapproval.googleapis.com) OR (protoPayload.serviceName=monitoring.googleapis.com) OR (protoPayload.serviceName=serviceusage.googleapis.com) OR (protoPayload.serviceName=dataproc.googleapis.com) OR (protoPayload.serviceName=aiplatform.googleapis.com) OR (protoPayload.serviceName=cloudresourcemanager.googleapis.com))) OR (protoPayload.methodName = storage.objects.create OR protoPayload.methodName = storage.objects.delete OR protoPayload.methodName = storage.objects.update)) AND (severity=INFO OR severity=NOTICE)"

}