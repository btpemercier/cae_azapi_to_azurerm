variable "cae_name" {
  type     = string
  default  = "migrate-azapi-issue-cae"
  nullable = false
}

variable "log_analytics_workspace_name" {
  type     = string
  default  = "migrate-azapi-issue-analytics"
  nullable = false
}

variable "resource_group_name" {
  type     = string
  default  = "migrate-azapi-issue-rg"
  nullable = false
}

variable "resource_group_location" {
  type     = string
  default  = "North Europe"
  nullable = false
}
