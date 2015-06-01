define iis_site::createsite (
  #site settings
  $sitedirectory,
  $bindings,
  $sitename,
  $id                     = $::iis_site::params::id,

  #apppool settings
  $user                   = $::iis_site::params::user,
  $pass                   = $::iis_site::params::pass,
  $enable32app            = $::iis_site::params::enable32app,
  $apppoolname            = $sitename,
  $managedruntimeversion  = $::iis_site::params::managedruntimeversion,
  $queuelength            = $::iis_site::params::queuelength,

  #logging settings
  $logdirectory           = $::iis_site::params::logdirectory,
  $logfile_fields         = $::iis_site::params::logfile_fields,
  Variant[String, Enum['Daily', 'Hourly','MaxSize','Monthly','Weekly']]
  $log_rotation_period    = $::iis_site::params::log_rotation_period,
  Variant[Boolean, Enum['true', 'false']]
  $logfile_enabled        = $::iis_site::params::logfile_enabled,
) {
  #settings apppool default
  Iis_apppool {
    ensure                    => present,
    managedpipelinemode       => 'Integrated',
    managedruntimeversion     => $managedruntimeversion,
    enable32bitapponwin64     => $enable32app,
    processmodel_identitytype => $user,
    queuelength               => $queuelength,
  }

  if($user in ['NetworkService','LocalService','LocalSystem']){
    iis_apppool {$apppoolname:}
  }
  else{
    iis_apppool {$apppoolname:
      processmodel_identitytype => 'SpecificUser',
      processmodel_username     => $user,
      processmodel_password     => $pass,
    }
  }
  #settings site default
  Iis_site {
    ensure                  => present,
    serverautostart         => true,
    bindings                => $bindings,
    logfile_enabled         => $logfile_enabled,
    logfile_logformat       => 'W3C',
    logfile_period          => $log_rotation_period,
    logfile_directory       => $logdirectory,
    logfile_logextfileflags => $logfile_fields,
  }

  if($id != '') {
    iis_site {$sitename:
      id => $id,
    }
  }
  else {
      iis_site {$sitename:}
  }

  iis_app {"$sitename/":
    ensure          => present,
    applicationpool => $apppoolname,
    require         => [Iis_site[$sitename],Iis_apppool[$apppoolname]]
  }

  iis_vdir {"$sitename/":
    ensure       => present,
    iis_app      => "$sitename/",
    physicalpath => $sitedirectory,
    require      => Iis_app["$sitename/"]
  }
}
