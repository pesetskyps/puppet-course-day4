class profile::base::allproducts::myservice{
  $services_create = hiera_hash('myservice::create')
  $service_defaults = hiera_hash('windows_service::create_service::defaults')
  create_resources('ps_myservice::create', $services_create, $service_defaults)

  $services_deploy = hiera_hash('myservice::deploy')
  create_resources('ps_myservice::deploy', $services_deploy)
} 