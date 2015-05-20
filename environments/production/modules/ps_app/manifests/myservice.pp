class ps_app::myservice($user,$pass){
  $myserviceservice_login = $user
  $myserviceservice_pass = $pass
  $service = 'myservice'
  $local_myserviceservice_path = 'C:\ps\service\NorthWind.console.exe'
  $ps_local_myserviceservice_path = "New-Item -Type File ${local_myserviceservice_path} -Force"
  $ps_myservice_check_service = "\"if($(get-service *${service}*)) {exit 0} else {exit 1}\""
  $ps_myservice_check_service_login = "\"if($(Get-WmiObject win32_service | ?{\$_.name -eq \'${service}\'}).startname -eq \'${myserviceservice_login}\') {exit 0}else {exit 1}\""

  #set up servicedirectory
  #file { 'C:\ps':
  #  ensure  => directory,
  #  source_permissions => ignore,
  #}
  #file { 'C:\ps\service':
  #  ensure  => directory,
  #  source_permissions => ignore,
  #  require => File['C:\ps']
  #}
  $directories = ['c:\ps','c:\ps\service','c:\ps\logs']
  ps_common::create_directories {'myservice':
    directoryArray => $directories,
    before => [Exec["Install_${service}"],Unzip["wcf.zip"]]
  }

  file { 'c:\\temp\\wcf.zip':
    ensure             => file,
    source             => 'puppet:///modules/ps_app/wcf.zip',
    source_permissions => ignore,
  }

  unzip { "wcf.zip":
      source  => 'C:\temp\wcf.zip',
      creates => $local_myserviceservice_path,
      require => File['c:\\temp\\wcf.zip'],
  }

  #Create temp Service.exe
  #exec { $local_myserviceservice_path:
  #  command => "$powershell ${ps_local_myserviceservice_path}",
  #  creates => $local_myserviceservice_path,
  #}

  exec { "Install_${service}":
    command => "C:\\Windows\\system32\\cmd.exe /c sc create ${service} binPath= \"${local_myserviceservice_path}\"",
    require => Unzip["wcf.zip"],
    unless  => "$powershell ${ps_myservice_check_service}",
  }

  #Set user service will run from
  exec { "Set_user_${service}":
    command => "C:\\Windows\\system32\\cmd.exe /c sc.exe config ${service} obj= ${myserviceservice_login} password= ${myserviceservice_pass} & sc.exe config ${service} start= auto",
    require => Exec["Install_${service}"],
    unless  => "$powershell ${ps_myservice_check_service_login}",
  }
  
  service {$service :
    ensure => running,
    require => Exec["Set_user_${service}"],
  }
}
