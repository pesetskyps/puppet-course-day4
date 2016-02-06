# Class: class profile::dev::sqlexpress
#
#
class profile::dev::sqlexpress
(
	$include_powershell_module,
) 
{
	$sqlclass = hiera_hash('mssql::install')
	#install mssql
	file{"c:\\temp\\SQLEXPR_x64_ENU":
		ensure  			=> 'present',
		source  			=> "puppet:///modules/ps_sql/SQLEXPR_x64_ENU",
		recurse 			=> true,
		source_permissions 	=> ignore,
		before => Class["mssql"]
	}
	create_resources('class',$sqlclass)
	#set firewall
	include ps_sql::firewall
	#add powershell module on sql instance
	if ($include_powershell_module == true) {
		include ps_sql::powershell_module
	}
}