resource "azapi_resource" "container_app_environment" {
  type      = "Microsoft.App/managedEnvironments@2023-05-01"
  name      = var.cae_name
  parent_id = azurerm_resource_group.rg.id
  location  = azurerm_resource_group.rg.location

  response_export_values = ["*"]

  body = jsonencode({
    properties = {
      appLogsConfiguration = {
        destination = "log-analytics"
        logAnalyticsConfiguration = {
          customerId = azurerm_log_analytics_workspace.workspace.workspace_id
          sharedKey  = azurerm_log_analytics_workspace.workspace.primary_shared_key
        }
      }
    }
  })

  ignore_missing_property = true
}
