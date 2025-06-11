# data "archive_file" "archive_context" {
#   type        = var.archive_type
#   source_dir  = var.archive_source_dir
#   output_path = var.archive_output_path
# }

# resource "random_string" "suffix" {
#     length = 5
#     special = false
#     upper = false
# }
# resource "azurerm_storage_account" "storage_account" {
#   name                     = "${var.account_name}${random_string.suffix.result}"
#   resource_group_name      = var.rg_name
#   location                 = var.location
#   account_tier             = var.account_tier
#   account_replication_type = var.account_replication_type

#   #not required
#   depends_on = [data.archive_file.archive_context]

#   tags = var.tags
# }

# resource "azurerm_storage_container" "storage_container" {
#   name                  = var.container_name
#   storage_account_name  = azurerm_storage_account.storage_account.name
#   container_access_type = var.container_access_type
# }

# resource "azurerm_storage_blob" "storage_blob" {
#   name                   = var.blob_name
#   storage_account_name   = azurerm_storage_account.storage_account.name
#   storage_container_name = azurerm_storage_container.storage_container.name
#   type                   = var.blob_type
#   content_type           = var.blob_content_type

#   source = data.archive_file.archive_context.output_path
# }

# resource "time_static" "creation_time" {
#   depends_on = [azurerm_storage_blob.storage_blob]
# }

# resource "time_offset" "expiry_time" {
#   offset_hours = 1 #hidden
#   depends_on   = [time_static.creation_time]
# }

# data "azurerm_storage_account_sas" "storage_sas" {
#   connection_string = azurerm_storage_account.storage_account.primary_connection_string

#   start  = time_static.creation_time.rfc3339
#   expiry = time_offset.expiry_time.rfc3339

#   resource_types {
#     service   = false
#     container = false
#     object    = true
#   }

#   services {
#     blob  = true
#     queue = false
#     table = false
#     file  = false
#   }

#   permissions {
#     read    = true
#     write   = false
#     delete  = false
#     add     = false
#     tag     = false
#     process = false
#     filter  = false
#     update  = false
#     list    = false
#     create  = false
#   }
# }