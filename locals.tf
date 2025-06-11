locals {
  rg_name = format("%s-rg", var.name_prefix)

  docker_image_name = format("%s-app", var.name_prefix)

  aks_name = format("%s-aks", var.name_prefix)
  app_image_name = format("%s-app", var.name_prefix)

  acr_name = lower(replace(format("%scr", var.name_prefix), "-", ""))

  sa_name = lower(replace(format("%ssa", var.name_prefix), "-", ""))

   keyvault_name = format("%s-kv", var.name_prefix)

   tags = {
    Creator = "megha_kumari1@epam.com"
  }

  dns_name_label = "meghadnslabel"
  dns_prefix     = "${var.name_prefix}-k8s"
}