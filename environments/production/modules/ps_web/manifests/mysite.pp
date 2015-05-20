class ps_web::mysite($user,$pass,$enable32app='false'){
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
  ->
  iis_site {'mysite':
    ensure                  => present,
    serverautostart         => true,
    id                      => '10',
    bindings                => ["http/*:25999:"],
    logfile_enabled         => true,
    logfile_logformat       => 'W3C',
    logfile_period          => 'Hourly',
    logfile_directory       => 'C:\ps\logs\iis',
    logfile_logextfileflags => 'Date, Time, ClientIP, UserName, ServerIP, Method, UriStem, UriQuery, HttpStatus, TimeTaken, ServerPort, UserAgent, Referer, Host',
  }
  ->
  iis_app {'mysite/':
    ensure          => present,
    applicationpool => 'PuppetIisDemo',
  }
  ->
  iis_vdir {'mysite/':
    ensure          => present,
    iis_app         => 'mysite/',
    physicalpath    => 'C:\ps\site'
  }
  # file { 'C:\ps':
  #   ensure  => directory,
  #   source_permissions => ignore,
  # }
  # file { 'C:\ps\site':
  #   ensure  => directory,
  #   source_permissions => ignore,
  #   require => File['C:\ps']
  # }
  
  file { 'c:\\temp\\web.zip':
    ensure             => file,
    source             => 'puppet:///modules/ps_web/web.zip',
    source_permissions => ignore,
  }
  unzip { "web.zip":
      source  => 'C:\temp\web.zip',
      creates => 'C:\ps\site\web.config',
  }

  $directories = ['c:\ps','c:\ps\site','c:\ps\logs']
  ps_common::create_directories {'mysite':
    directoryArray => $directories,
    before => Unzip["web.zip"]
  }
}
