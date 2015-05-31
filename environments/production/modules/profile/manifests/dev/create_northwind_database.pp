# Class: profile::dev::create_northwind_database
#
#
class profile::dev::create_northwind_database {
	class {'ps_sql::fill_northwind_db':
		instance 				=> $hostname,
		database_check_script 	=> 'ps_sql/powershell/check_dabatase_exist.ps1',
		database_create_sql_script => 'puppet:///modules/ps_sql/instnwnd.sql',
		require => Class['mssql'],
	}
}