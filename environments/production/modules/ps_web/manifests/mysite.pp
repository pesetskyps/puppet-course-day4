class ps_web::mysite (
  #site settings
  $sitedirectory,
  $bindings,
  $sitename               = $::ps_web::mysite::params::sitename,
  $id                     = $::ps_web::mysite::params::id,
  #deplyment settings
  Variant[Boolean, Enum['true', 'false']]
  $deploy                 = $::ps_web::mysite::params::deploy, 
  $deploypackLocation     = $::ps_web::mysite::params::deploypackLocation,

  #apppool settings
  $user                   = $::ps_web::mysite::params::user,
  $pass                   = $::ps_web::mysite::params::pass,
  $enable32app            = $::ps_web::mysite::params::enable32app,
  $apppoolname            = $::ps_web::mysite::params::apppoolname,
  $managedruntimeversion  = $::ps_web::mysite::params::managedruntimeversion,
  $queuelength            = $::ps_web::mysite::params::queuelength,

  #logging settings
  $logdirectory           = $::ps_web::mysite::params::logdirectory,
  $logfile_fields         = $::ps_web::mysite::params::logfile_fields,
  Variant[String, Enum['Daily', 'Hourly','MaxSize','Monthly','Weekly']]
  $log_rotation_period    = $::ps_web::mysite::params::log_rotation_period,
  Variant[Boolean, Enum['true', 'false']]
  $logfile_enabled        = $::ps_web::mysite::params::logfile_enabled,
) inherits ps_web::mysite::params {
  # include ps_web::copy_files_old
  include ps_web::copy_files_new

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
