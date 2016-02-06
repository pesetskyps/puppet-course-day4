# Class: class profile::dev::sqlexpress
#
#
class profile::base::allproducts::sqlexpress
(
	$include_powershell_module = hiera(sqlexpress::include_powershell_module),
) 
{
	$sqlclass = hiera_hash('mssql::install')
	#install mssql
	create_resources('class',$sqlclass)
	#set firewall
	include ps_sql::firewall
	#add powershell module on sql instance
	if ($include_powershell_module == true) {
		include ps_sql::powershell_module
	}
}