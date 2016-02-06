define ps_myservice::deploy(
	$servicename,
	$deploy_pack_puppet_path,
	$deploy_pack_windows_temp_path,
	$creates_file,
	$service_directory
)
{
	windows_service::deploy_service { $servicename:
		servicename => $servicename,
	 	deploy_pack_puppet_path => $deploy_pack_puppet_path,
	 	deploy_pack_windows_temp_path => $deploy_pack_windows_temp_path,
	 	creates_file => $creates_file,
	 	service_directory => $service_directory,
	}
}