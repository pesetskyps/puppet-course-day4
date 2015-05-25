class ps_app::myservice($user,$pass){
  include ps_app::copy_files_old
  # include ps_app::copy_files_new

  $service = 'myservice'
  $local_myserviceservice_path = 'C:\ps\service\NorthWind.console.exe'
  $ps_local_myserviceservice_path = "New-Item -Type File ${local_myserviceservice_path} -Force"
  $ps_myservice_check_service = "\"if($(get-service *${service}*)) {exit 0} else {exit 1}\""
  $ps_myservice_check_service_login = "\"if($(Get-WmiObject win32_service | ?{\$_.name -eq \'${service}\'}).startname -eq \'${user}\') {exit 0}else {exit 1}\""

  exec { "Install_${service}":
    command => "C:\\Windows\\system32\\cmd.exe /c sc create ${service} binPath= \"${local_myserviceservice_path}\"",
    require => Class['ps_app::copy_files_old'],
    # require => Class['ps_app::copy_files_new'],
    unless  => "$powershell ${ps_myservice_check_service}",
  }

  #Set user service will run from
  exec { "Set_user_${service}":
    command => "C:\\Windows\\system32\\cmd.exe /c sc.exe config ${service} obj= ${user} password= ${pass} & sc.exe config ${service} start= auto",
    require => Exec["Install_${service}"],
    unless  => "$powershell ${ps_myservice_check_service_login}",
  }
  
  service {$service :
    ensure => running,
    require => Exec["Set_user_${service}"],
  }
}
