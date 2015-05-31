class windows_service::deploy_service(
$servicename,
$deploy_pack_puppet_path,
$deploy_pack_windows_temp_path,
$creates_file,
$directories,
)
{
  ps_common::create_directories {$servicename:
    directoryArray => $directories,
    before         => Unzip[$servicename]
  }

  file { $deploy_pack_windows_temp_path:
    ensure              => file,
    source              => $deploy_pack_puppet_path,
    source_permissions  => ignore,
  }

  unzip { $servicename:
      source  => $deploy_pack_windows_temp_path,
      creates => $creates_file,
      require => File[$deploy_pack_windows_temp_path],
  }
}