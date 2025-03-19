module "azure_container_apps" {
  source                    = "./modules/aca"
  app_name                  = "azure"
  image                     = "alexrsit/nextjsapp:1.1.2"
  cpu                       = "0.5"
  memory                    = "1Gi"
  external_enabled          = true
  target_port               = 3000
  certificate_friendly_name = "rosta.dev"
  certificate_path          = "./certificate/cert.pfx"
  certificate_password      = var.certificate_password
  zone_id                   = var.zone_id
  root_domain               = "rosta.dev"
}

module "azure_redis" {
  source              = "./modules/redis"
  resource_group_name = module.azure_container_apps.resource_group_name
  redis_name          = "${module.azure_container_apps.app_name}-redis"
  start_ip_allow      = module.azure_container_apps.static_ip_address
  end_ip_allow        = module.azure_container_apps.static_ip_address
}


