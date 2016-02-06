define windows_service::deploy_service(
  $servicename,
  $deploy_pack_puppet_path,
  $deploy_pack_windows_temp_path,
  $creates_file,
  $service_directory
)
{
  exec {"create_$service_directory":
    command => template('windows_service/powershell/create_directory.ps1'),
    creates  => "$service_directory",
    provider => powershell,
    logoutput => "on_failure",
  }

  file { $deploy_pack_windows_temp_path:
    ensure              => file,
    source              => $deploy_pack_puppet_path,
    source_permissions  => ignore,
  }

  unzip { $servicename:
      source  => $deploy_pack_windows_temp_path,
      creates => $creates_file,
      require => [File[$deploy_pack_windows_temp_path],Exec["create_${service_directory}"]],
  }
}