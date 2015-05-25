class ps_sql::sqlexpress(){
	class {'mssql':
		media          => 'c:\\temp\\SQLEXPR_x64_ENU',
		instancename   => 'MSSQLSERVER',
		features       => 'SQLENGINE',
		sqlsvcaccount  => 'HOSTING\pesetskp',
		sqlsvcpassword => 'Epam_2010',
		instancedir    => 'C:\\Program Files\\Microsoft SQL Server',
		ascollation    => 'Latin1_General_CI_AS',
		sqlcollation   => 'SQL_Latin1_General_CP1_CI_AS',
		admin          => '"HOSTING\pesetskp"',
		sapwd          => 'Epam_2010',
		iniFile        => 'ps_sql/ConfigurationFile.ini'
	}

	#install SharedManagementObjects
	$sharedManagementObjects_package_name = 'SharedManagementObjects.msi'
	$sharedManagementObjects_local_path = "c:\\temp\\$sharedManagementObjects_package_name"
	$sharedManagementObjects_puppet_path = "puppet:///modules/ps_sql/$sharedManagementObjects_package_name"

	#Copy source files
	file { $sharedManagementObjects_local_path:
		ensure             => 'present',
		source             => $sharedManagementObjects_puppet_path,
		source_permissions => ignore,
	}
	#install
	package { 'Microsoft SQL Server 2014 Management Objects  (x64)':
		ensure          => '12.0.2000.8',
		source          => $sharedManagementObjects_local_path,
		install_options => [ '/quiet'],
		require 		=> [File[$sharedManagementObjects_local_path],Class['mssql']]
	}

	#install powershell module
	$powerShellTools_package_name = 'PowerShellTools.msi'
	$powerShellTools_local_path = "c:\\temp\\$powerShellTools_package_name"
	$powerShellTools_puppet_path = "puppet:///modules/ps_sql/$powerShellTools_package_name"

	#Copy source files
	file { $powerShellTools_local_path:
		ensure             => 'present',
		source             => $powerShellTools_puppet_path,
		source_permissions => ignore,
	}
	#install
	package { 'Windows PowerShell Extensions for SQL Server 2014 ':
		ensure          => '12.0.2000.8',
		source          => $powerShellTools_local_path,
		install_options => [ '/quiet'],
		require 		=> [File[$powerShellTools_local_path], Package['Microsoft SQL Server 2014 Management Objects  (x64)']]
	}
	$ps_change_modulepath = '"\$CurrentValue = [Environment]::GetEnvironmentVariable(\'PSModulePath\', \'Machine\');[Environment]::SetEnvironmentVariable(\'PSModulePath\', \$CurrentValue + \';C:\Program Files\Microsoft SQL Server\120\Tools\PowerShell\Modules\', \'Machine\')\"'
	exec { "$ps_change_modulepath":
		command => "$powershell $ps_change_modulepath",
		subscribe => Package['Windows PowerShell Extensions for SQL Server 2014 ']
	}	
}
