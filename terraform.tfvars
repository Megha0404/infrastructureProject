location = "southindia"

name_prefix = "finalProject"


#Docker
dockerfile_path           = "Dockerfile"
docker_build_context_path = "https://github.com/Megha0404/task081#main:task08/application"
docker_image_name         = "cmtr-2olzzm40-mod8-app"



#acr
acr_task_name   = "megha-acr1"
acr_sku         = "Basic"
platform_os     = "Linux"


#kv
kv_sku = "standard"

#aks
system_node_pool_name       = "system"
system_node_pool_node_count = 1
system_node_pool_vm_size    = "Standard_D2ads_v5"

