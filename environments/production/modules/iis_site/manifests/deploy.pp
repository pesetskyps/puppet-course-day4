define iis_site::deploy(
  $sitename,
  $deploy_pack_puppet_path,
  $deploy_pack_windows_temp_path,
  $creates_file,
  $site_directory
)
{
  exec {"create_$site_directory":
    command => template('iis_site/powershell/create_directory.ps1'),
    creates  => "$site_directory",
    provider => powershell,
    logoutput => "on_failure",
  }

  file { $deploy_pack_windows_temp_path:
    ensure              => file,
    source              => $deploy_pack_puppet_path,
    source_permissions  => ignore,
  }

  unzip { $sitename:
      source  => $deploy_pack_windows_temp_path,
      creates => $creates_file,
      destination => $site_directory,
      require => [File[$deploy_pack_windows_temp_path],Exec["create_${site_directory}"]],
  }
}