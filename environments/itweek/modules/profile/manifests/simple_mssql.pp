# Class: class profile::mssql
#
#
class profile::mssql
(
	$include_powershell_module = true,
) 
{
	class {'mssql':
		media => 'c:\temp\SQLEXPR_x64_ENU',
		instancename => 'MSSQLSERVER',
		features => 'SQLENGINE'
		instancedir => 'C:\Program Files\Microsoft SQL Server'
		ascollation => 'Latin1_General_CI_AS'
		sqlcollation => 'SQL_Latin1_General_CP1_CI_AS'
		admin => "$::hostname\\SQLSVC"
		sapwd => 'Zabbix_2015'
		iniFile => 'ps_sql/ConfigurationFile.ini'
	}

	include ps_sql::firewall
	#add powershell module on sql instance
	if ($include_powershell_module == true) {
		include ps_sql::powershell_module
	}
}