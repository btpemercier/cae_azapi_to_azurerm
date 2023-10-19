# Azure Container App Environment from AZAPI to AzureRM

## Introduction

The goal of this repository is to provide a simple way to reproduce the following issue

* Impossible to import the CAE resource from azapi to azurerm without recreating the resource, because the analytical log workspace is not taken into account

## How to

## Step 1 : Create the CAE resource with azapi
* `make init`
* Log into your Azure account and select the subscription you want to use
* `make plan` and `make apply`

```shell
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

## Step 2 : Import the CAE resource with azurerm

* Rename `cae_azapi.tf` to `cae_azapi.tf.disabled`
* Rename `cae_azurerm.tf.disabled` to `cae_azurerm.tf`
* Change the import identifier in `cae_azurerm.tf` to match the id of the CAE resource created by azapi
* `make plan`

### Actual result

```shell
  # azapi_resource.container_app_environment will be destroyed
  # (because azapi_resource.container_app_environment is not in configuration)
  - resource "azapi_resource" "container_app_environment" {
      - body                      = (sensitive value) -> null
      - id                        = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/migrate-azapi-issue-rg/providers/Microsoft.App/managedEnvironments/migrate-azapi-issue-cae" -> null
      - ignore_casing             = false -> null
      - ignore_missing_property   = true -> null
      - location                  = "North Europe" -> null
      - name                      = "migrate-azapi-issue-cae" -> null
      - output                    = jsonencode(
            {
              - id         = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/migrate-azapi-issue-rg/providers/Microsoft.App/managedEnvironments/migrate-azapi-issue-cae"
              - location   = "North Europe"
              - name       = "migrate-azapi-issue-cae"
              - properties = {
                  - appLogsConfiguration        = {
                      - destination               = "log-analytics"
                      - logAnalyticsConfiguration = {
                          - customerId = "00000000-0000-0000-0000-000000000000"
                          - sharedKey  = null
                        }
                    }
                  - customDomainConfiguration   = {
                      - certificatePassword        = null
                      - certificateValue           = null
                      - customDomainVerificationId = "12EDBFD48AB02B0DA0F8AF6B2D7762248B14187E370BB5DB07EE4FA0CA5D0224"
                      - dnsSuffix                  = null
                      - expirationDate             = null
                      - subjectName                = null
                      - thumbprint                 = null
                    }
                  - daprAIConnectionString      = null
                  - daprAIInstrumentationKey    = null
                  - daprConfiguration           = {
                      - version = "1.11.2"
                    }
                  - defaultDomain               = "mydefault-domain.northeurope.azurecontainerapps.io"
                  - eventStreamEndpoint         = "https://northeurope.azurecontainerapps.dev/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/migrate-azapi-issue-rg/managedEnvironments/migrate-azapi-issue-cae/eventstream"
                  - firstPartyConfiguration     = null
                  - infrastructureResourceGroup = null
                  - kedaConfiguration           = {
                      - version = "2.10.0"
                    }
                  - peerAuthentication          = {
                      - mtls = {
                          - enabled = false
                        }
                    }
                  - provisioningState           = "Succeeded"
                  - staticIp                    = "1.2.3.4"
                  - vnetConfiguration           = null
                  - workloadProfiles            = null
                  - zoneRedundant               = false
                }
              - type       = "Microsoft.App/managedEnvironments"
            }
        ) -> null
      - parent_id                 = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/migrate-azapi-issue-rg" -> null
      - removing_special_chars    = false -> null
      - response_export_values    = [
          - "*",
        ] -> null
      - schema_validation_enabled = true -> null
      - tags                      = {} -> null
      - type                      = "Microsoft.App/managedEnvironments@2023-05-01" -> null
    }


  # azurerm_container_app_environment.environment must be replaced
  # (imported from "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/migrate-azapi-issue-rg/providers/Microsoft.App/managedEnvironments/migrate-azapi-issue-cae")
  # Warning: this will destroy the imported resource
-/+ resource "azurerm_container_app_environment" "environment" {
      ~ default_domain                   = "mydefault-domain.northeurope.azurecontainerapps.io" -> (known after apply)
      + docker_bridge_cidr               = (known after apply)
      ~ id                               = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/migrate-azapi-issue-rg/providers/Microsoft.App/managedEnvironments/migrate-azapi-issue-cae" -> (known after apply)
        internal_load_balancer_enabled   = false
        location                         = "northeurope"
      + log_analytics_workspace_id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/migrate-azapi-issue-rg/providers/Microsoft.OperationalInsights/workspaces/migrate-azapi-issue-analytics" # forces replacement
        name                             = "migrate-azapi-issue-cae"
      + platform_reserved_cidr           = (known after apply)
      + platform_reserved_dns_ip_address = (known after apply)
        resource_group_name              = "migrate-azapi-issue-rg"
      ~ static_ip_address                = "1.2.3.4" -> (known after apply)
      - tags                             = {} -> null
        zone_redundancy_enabled          = false
    }

Plan: 1 to import, 1 to add, 0 to change, 2 to destroy.
```

### Expected result

The import should not destroy / add or change something

```shell
Plan: 1 to import, 0 to add, 0 to change, 0 to destroy.
```
