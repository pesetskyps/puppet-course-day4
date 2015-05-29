# Define: create_service
 # Installs the service in the directory by creation temporary exe. 
 # Optionally package can be deployed
 # Parameters:
 # username: if specify LocalSystem Account as parameter use password => "`\"`\""
 # config_deploy_path: path to deploy the config on windows machine
 # config_puppet_path: path in puppet to bringthe config from
 define windows_service::create_service (
 	$servicename,
 	$servicedirectory,
 	#Name of the exe file that will be started as windows service: e.g. NorthWind.console.exe
 	$exe_Name,
 	Variant[String, Enum['auto', 'demand', 'disabled']]
 	$startup_type = 'demand', 	
 	$username = '',
 	$password = '',
 	Variant[Boolean, Enum['true', 'false']]
 	$running = false,
	Variant[Boolean, Enum['true', 'false']]
	$deploy                 = false, 
	$deploypackLocation     = '',
	$configs= '',
 ) 
 {
 	if(($deploy == true) and ($deploypackLocation == '')){
 		fail("Please specify the deploy pack location at puppet master in format: puppet:///<modulename>/<path in module files directory>")
 	}
 	if (($username != '') and ($password == '')) {
 		fail("Please specify a password for the user ${username}")
 	}
 	validate_re($servicedirectory, '^.*[^\\\\/]$',"Please remove trailing slash from the directory name $servicedirectory")

 	# to get out of the difference between wmi and sc.exe (welcome to Windows my friend :)
 	$ps_service_mode = $startup_type ? {
 		'demand' => 'Manual',
 		'auto' => 'Auto',
 		'disabled' => 'Disabled',
 		default => 'value',
 	}

 	$local_service_path = "${servicedirectory}\\${exe_Name}"

 	exec { "Create_${servicename}_Path":
 	  command => template('windows_service/powershell/create_temp_file.ps1'),
 	  creates  => "$local_service_path",
 	  provider => powershell,
 	  logoutput => "on_failure",
 	}
 	exec { "Install_${servicename}":
 	  command => "C:\\Windows\\system32\\cmd.exe /c sc create ${servicename} binPath= \"${local_service_path}\"",
 	  require => Exec["Create_${servicename}_Path"],
 	  provider => powershell,
 	  unless  => template('windows_service/powershell/check_service.ps1'),
 	  logoutput => "on_failure",
 	}
 	#Set mode service will run
 	exec { "Set_startmode_${servicename}":
 	  command => "C:\\Windows\\system32\\cmd.exe /c sc.exe config ${servicename} start= ${startup_type}",
 	  require => Exec["Install_${servicename}"],
 	  provider => powershell,
 	  unless  => template('windows_service/powershell/check_service_mode.ps1'),
 	  logoutput => "on_failure",
 	}
 	if($username != ''){
	 	#Set user service will run from
	 	exec { "Set_user_${servicename}":
	 	  command => "C:\\Windows\\system32\\cmd.exe /c sc.exe config ${servicename} obj= ${username} password= ${password}",
	 	  require => Exec["Install_${servicename}"],
	 	  provider => powershell,
	 	  unless  => template('windows_service/powershell/check_service_login.ps1'),
	 	  logoutput => "on_failure",
	 	}
 	}
 	if(($deploy == true) and ($running == true)){
 		# include ps_app::copy_files_old
 		include ps_app::copy_files_new
	 	service {$servicename :
	 	  ensure => running,
	 	  require => Exec["Install_${servicename}"],
	 	}
 	}

 	if($configs != ''){
 		validate_hash($configs)
		$configs.each |String $config_name, Hash $config_values| {
			file { "${servicename}_${config_name}":
				ensure => file,
			}
		}
 	}
 } 