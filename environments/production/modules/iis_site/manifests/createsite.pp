define iis_site::createsite (
  #site settings
  $sitedirectory,
  $bindings,
  $sitename,
  $id,

  #apppool settings
  $user,
  $pass,
  $enable32app,
  $apppoolname,
  $managedruntimeversion,
  $queuelength,

  #logging settings
  $logdirectory,
  $logfile_fields,
  Variant[String, Enum['Daily', 'Hourly','MaxSize','Monthly','Weekly']]
  $log_rotation_period,
  Variant[Boolean, Enum['true', 'false']]
  $logfile_enabled,
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
