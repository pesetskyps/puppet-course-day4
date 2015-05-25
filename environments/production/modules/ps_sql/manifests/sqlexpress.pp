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

	include ps_sql::firewall
	include ps_sql::powershell_module	
}
