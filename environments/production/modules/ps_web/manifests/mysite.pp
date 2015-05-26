class ps_web::mysite($user='NetworkService',$pass='null',$enable32app=false){
  # include ps_web::copy_files_old
  include ps_web::copy_files_new
  if(($user == 'NetworkService')){
    iis_apppool {'PuppetIisDemo':
      ensure                    => present,
      managedpipelinemode       => 'Integrated',
      managedruntimeversion     => 'v4.0',
      enable32bitapponwin64     =>  $enable32app,
      processmodel_identitytype => 'NetworkService',
      queuelength               => '10000',
    }
  }
  else{
    iis_apppool {'PuppetIisDemo':
      ensure                    => present,
      managedpipelinemode       => 'Integrated',
      managedruntimeversion     => 'v4.0',
      processmodel_identitytype => 'SpecificUser',
      processmodel_username     => $user,
      processmodel_password     => $pass,
      enable32bitapponwin64     =>  $enable32app,
      queuelength               => '10000',
    }
  }

  iis_site {'mysite':
    ensure                  => present,
    serverautostart         => true,
    id                      => '10',
    bindings                => ['http/*:25999:'],
    logfile_enabled         => true,
    logfile_logformat       => 'W3C',
    logfile_period          => 'Hourly',
    logfile_directory       => 'C:\ps\logs\iis',
    logfile_logextfileflags => 'Date, Time, ClientIP, UserName, ServerIP, Method, UriStem, UriQuery, HttpStatus, TimeTaken, ServerPort, UserAgent, Referer, Host',
    require                 => Iis_apppool['PuppetIisDemo']
  }
  ->
  iis_app {'mysite/':
    ensure          => present,
    applicationpool => 'PuppetIisDemo',
  }
  ->
  iis_vdir {'mysite/':
    ensure       => present,
    iis_app      => 'mysite/',
    physicalpath => 'C:\ps\site'
  }
}
