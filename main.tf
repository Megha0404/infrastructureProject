provider "azurerm" {
  features {}
}

data "azurerm_client_config" "client_config" {}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location

  tags = local.tags
}


# module "storage" {
#   source = "./modules/storage"

#   rg_name  = azurerm_resource_group.rg.name
#   location = azurerm_resource_group.rg.location

#   account_name             = local.sa_name
#   account_tier             = var.storage_account_tier
#   account_replication_type = var.storage_account_replication_type

#   container_name        = var.storage_container_name
#   container_access_type = var.storage_container_access_type

#   blob_name         = var.storage_blob_name
#   blob_content_type = var.blob_content_type
#   blob_type         = var.blob_type

#   archive_type        = var.archive_type
#   archive_source_dir  = var.archive_source_dir
#   archive_output_path = var.archive_output_path

#   tags = local.tags
#   depends_on = [ azurerm_resource_group.rg ]
# }


module "acr" {
  source = "./modules/acr"

  rg_name       = azurerm_resource_group.rg.name
  location      = azurerm_resource_group.rg.location
  acr_name      = local.acr_name
  acr_task_name = var.acr_task_name
  acr_sku       = var.acr_sku
  platform_os   = var.platform_os

  dockerfile_path           = var.dockerfile_path
  docker_build_context_path = var.docker_build_context_path
  context_access_token      = var.context_access_token
  docker_image_name         = local.app_image_name

  tags = local.tags
}




module "kv" {
  source = "./modules/keyvault"

  kv_name  = local.keyvault_name
  rg_name  = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  sku_name = var.kv_sku

  tenant_id = data.azurerm_client_config.client_config.tenant_id
  object_id = data.azurerm_client_config.client_config.object_id

  tags       = local.tags
  depends_on = [module.acr]
}


module "aks" {
  source = "./modules/aks"

  aks_cluster_name = local.aks_name
  rg_name          = azurerm_resource_group.rg.name
  location         = azurerm_resource_group.rg.location
  dns_prefix       = local.dns_prefix

  system_node_pool_name       = var.system_node_pool_name
  system_node_pool_node_count = var.system_node_pool_node_count
  system_node_pool_vm_size    = var.system_node_pool_vm_size

  acr_id       = module.acr.acr_id
  tenant_id    = data.azurerm_client_config.client_config.tenant_id
  key_vault_id = module.kv.kv_id

  tags       = local.tags
  depends_on = [module.acr, module.kv, azurerm_resource_group.rg]
}


provider "kubectl" {
  host                   = yamldecode(module.aks.aks_kube_config).clusters[0].cluster.server
  client_certificate     = base64decode(yamldecode(module.aks.aks_kube_config).users[0].user.client-certificate-data)
  client_key             = base64decode(yamldecode(module.aks.aks_kube_config).users[0].user.client-key-data)
  cluster_ca_certificate = base64decode(yamldecode(module.aks.aks_kube_config).clusters[0].cluster.certificate-authority-data)
  load_config_file       = false
}

provider "kubernetes" {
  host                   = yamldecode(module.aks.aks_kube_config).clusters[0].cluster.server
  client_certificate     = base64decode(yamldecode(module.aks.aks_kube_config).users[0].user.client-certificate-data)
  client_key             = base64decode(yamldecode(module.aks.aks_kube_config).users[0].user.client-key-data)
  cluster_ca_certificate = base64decode(yamldecode(module.aks.aks_kube_config).clusters[0].cluster.certificate-authority-data)
}



