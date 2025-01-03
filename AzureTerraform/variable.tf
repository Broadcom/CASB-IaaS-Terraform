#Replace the perpetual_token from the CloudSoc Azure script downloaded from the connection"
variable "delivery_properties" {
  description = "Replace the perpetual_token from the CloudSoc Azure script downloaded from the connection"
  type = list(object({
    delivery_property_header_name = optional(string)
    delivery_property_type        = optional(string)
    delivery_property_value       = optional(string)
    delivery_property_secret      = optional(bool)
    delivery_property_source      = optional(string)
  }))

  default = [{
    delivery_property_header_name = "Authorization"
    delivery_property_type        = "Static"
    delivery_property_value       = "Bearer <perpetual_token>"
    delivery_property_secret      = true
    }
  ]
}

variable "event_types_filter" {
  type    = list(string)
  default = ["Microsoft.Resources.ResourceWriteSuccess", "Microsoft.Resources.ResourceDeleteSuccess", "Microsoft.Resources.ResourceActionSuccess"]
}

variable "webhook_url" {
  description = "Enter the webhook_url from the CloudSoc Azure script downloaded from the connection"
  type        = string
  default     = ""
}

variable "cloudsoc_tenant_id" {
  description = "Enter the cloudsoc_tenant_id from the CloudSoc azure script downloaded from the connection"
  type        = string
  default     = "<cloudsoc_tenant_id>"
}

variable "eventgrid_subscription_name" {
  type    = string
  default = "cloudsoceventsubscription"
}
variable "app_name" {
  description = "Enter Azure AD app name created for CloudSoc"
  type        = string
  default     = "<cloudsoc_brcm_conn_app>" #
}

variable "reader_role_name" {
  type    = string
  default = "Reader"
}

variable "storage_blob_data_reader_role_name" {
  type    = string
  default = "Storage Blob Data Reader"
}

variable "azure_subscriptions_input" {
  description = "Enter the list of subscriptions to be provisioned for CloudSoc. If this is list is empty all, all subscription will be provisioned for CloudSoc"
  type        = list(string)
  default     = []
}

variable "storage_eventgrid_name" {
  type    = string
  default = "cloudsocstorageevent"
}

#Filter for storage event grid
variable "storage_event_types_filter" {
  type    = list(string)
  default = ["Microsoft.Storage.BlobCreated", "Microsoft.Storage.BlobDeleted"]
}