output "available_subscriptions" {
  value = data.azurerm_subscriptions.available.subscriptions.*.subscription_id
}

output "subscriptions_to_be_processed" {
  value = local.subscription_list
}

output "reader_role_id" {
  value = data.azurerm_role_definition.reader_role.id
}

output "storage_blob_data_reader_role_id" {
  value = data.azurerm_role_definition.storage_blob_data_reader_role.id
}

output "app_name_object_id" {
  value = data.azuread_service_principal.app_sp.object_id
}

output "storages_to_be_processed" {
  value =   flatten([for r in data.azapi_resource_list.listBySubscription : r.output.id])
}