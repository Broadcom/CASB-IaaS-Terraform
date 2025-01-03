
locals {
  subscription_list  = length(var.azure_subscriptions_input) > 0 ? var.azure_subscriptions_input : data.azurerm_subscriptions.available.subscriptions.*.subscription_id
  subscription_count = length(var.azure_subscriptions_input) > 0 ? length(var.azure_subscriptions_input) : length(data.azurerm_subscriptions.available.subscriptions.*.subscription_id)
}


data "azurerm_subscriptions" "available" {
}

data "azurerm_role_definition" "reader_role" {
  name = var.reader_role_name
}

data "azurerm_role_definition" "storage_blob_data_reader_role" {
  name = var.storage_blob_data_reader_role_name
}

data "azuread_application" "app" {
  display_name = var.app_name
}

data "azuread_service_principal" "app_sp" {
  client_id = data.azuread_application.app.client_id
}

resource "random_uuid" "random_id_1" {
}
resource "random_uuid" "random_id_2" {
}

resource "azurerm_role_assignment" "storage_blob_data_reader_role_assignment" {
  count              = local.subscription_count
  name               = random_uuid.random_id_1.result
  scope              = "/subscriptions/${element(local.subscription_list, count.index)}"
  role_definition_id = "/subscriptions/${element(local.subscription_list, count.index)}${data.azurerm_role_definition.storage_blob_data_reader_role.id}"
  principal_id       = data.azuread_service_principal.app_sp.object_id
}

resource "azurerm_role_assignment" "reader_role_assignment" {
  count              = local.subscription_count
  name               = random_uuid.random_id_2.result
  scope              = "/subscriptions/${element(local.subscription_list, count.index)}"
  role_definition_id = "/subscriptions/${element(local.subscription_list, count.index)}${data.azurerm_role_definition.reader_role.id}"
  principal_id       = data.azuread_service_principal.app_sp.object_id
}


resource "azurerm_eventgrid_event_subscription" "azure_subscription_eventgrid_event_subscription_creation" {
  name  = "${var.eventgrid_subscription_name}-${var.cloudsoc_tenant_id}"
  count = local.subscription_count
  scope = "/subscriptions/${element(local.subscription_list, count.index)}"

  webhook_endpoint {
    url = var.webhook_url
  }
  included_event_types = var.event_types_filter
  dynamic "delivery_property" {
    for_each = var.delivery_properties != null ? [for s in var.delivery_properties : {
      header_name  = s.delivery_property_header_name
      type         = s.delivery_property_type
      value        = s.delivery_property_value
      source_field = s.delivery_property_source
      secret       = s.delivery_property_secret
    }] : []

    content {
      header_name  = delivery_property.value.header_name
      type         = delivery_property.value.type
      value        = delivery_property.value.value
      source_field = delivery_property.value.source_field
      secret       = delivery_property.value.secret
    }
  }

}

# Get list of storage accounts of kind StorageV2 and BlockBlobStorage as these are only supported
data "azapi_resource_list" "listBySubscription" {
  type      = "Microsoft.Storage/storageAccounts@2023-05-01" #TBD
  count = local.subscription_count
  parent_id = "/subscriptions/${element(local.subscription_list, count.index)}"
  response_export_values = {
  "id" = "value[?kind == 'StorageV2'||'BlockBlobStorage'].id"
  }
}

#Set event grid to all storages with filter
resource "azurerm_eventgrid_event_subscription" "azure_storage_account_eventgrid_event_subscription_creation" {
  name  = "${var.storage_eventgrid_name}-${var.cloudsoc_tenant_id}"
  for_each = toset(flatten([for r in data.azapi_resource_list.listBySubscription : r.output.id]))
  scope = each.key

  webhook_endpoint {
    url = var.webhook_url
  }
  included_event_types = var.storage_event_types_filter
  dynamic "delivery_property" {
    for_each = var.delivery_properties != null ? [for s in var.delivery_properties : {
      header_name  = s.delivery_property_header_name
      type         = s.delivery_property_type
      value        = s.delivery_property_value
      source_field = s.delivery_property_source
      secret       = s.delivery_property_secret
    }] : []

    content {
      header_name  = delivery_property.value.header_name
      type         = delivery_property.value.type
      value        = delivery_property.value.value
      source_field = delivery_property.value.source_field
      secret       = delivery_property.value.secret
    }
  }
}







