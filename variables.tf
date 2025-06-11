variable "location" {
  type        = string
  description = "location"
}
variable "name_prefix" {
  type        = string
  description = "sku"
}


variable "dockerfile_path" {
  type        = string
  description = "sku"
}
variable "docker_build_context_path" {
  type        = string
  description = "sku"
}
variable "docker_image_name" {
  type        = string
  description = "sku"
}





#acr
variable "acr_sku" {
  type        = string
  description = "sku"
}
variable "platform_os" {
  type        = string
  description = "sku"
}
variable "acr_task_name" {
  type        = string
  description = "sku"
}


variable "context_access_token" {
  type        = string
  description = "sku"
}


#kv
variable "kv_sku" {
  description = "sku"
  type        = string
}

#aks
variable "system_node_pool_name" {
  type        = string
  description = "sku"
}
variable "system_node_pool_node_count" {
  type        = number
  description = "sku"
}
variable "system_node_pool_vm_size" {
  type        = string
  description = "sku"
}



