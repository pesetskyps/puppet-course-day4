define ps_myservice::create(
 	$servicename,
 	$servicedirectory,
 	#Name of the exe file that will be started as windows service: e.g. NorthWind.console.exe
 	$exe_Name,
 	Variant[String, Enum['auto', 'demand', 'disabled']]
 	$startup_type, 	
 	$username,
 	$password,
	#config change
	$configs		
)
{
	windows_service::create_service { $servicename:
		servicename => $servicename,
	 	servicedirectory => $servicedirectory,
	 	exe_Name => $exe_Name,
	 	startup_type => $startup_type, 	
	 	username => $username,
	 	password => $password,
		configs => $configs,
	}
}