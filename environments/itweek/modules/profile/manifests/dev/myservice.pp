class profile::dev::myservice{
  $services = hiera_hash('windows_service::create_services')
  $service_defaults = hiera_hash('windows_service::create_service::defaults')
  create_resources('windows_service::create_service', $services,$service_defaults)
} 