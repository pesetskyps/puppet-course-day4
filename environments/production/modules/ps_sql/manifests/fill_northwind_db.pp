class ps_sql::fill_northwind_db($instance){
	windows_firewall::exception { 'Allow sql port':
	  ensure       => present,
	  direction    => 'in',
	  action       => 'Allow',
	  enabled      => 'yes',
	  protocol     => 'TCP',
	  local_port   => '1433',
	  display_name => 'Allow MSSQL TCP connection port',
	  description  => 'Allow MSSQL TCP connection port',
	}

	$ps_sql_db_exist_check = "\"invoke-sqlcmd -Query \'use Northwind;select top 1 * from orders\' -ServerInstance $instance -ErrorAction Stop\""
	$file_db_create = "c:\\temp\\instnwnd.sql"
	$ps_sql_db_create = "\"invoke-sqlcmd -InputFile \"$file_db_create\" -ServerInstance $instance -ErrorAction Stop\""

	file { "$file_db_create":
		ensure  => "present",
		source  => "puppet:///modules/ps_sql/instnwnd.sql",
		source_permissions => ignore,
	}
	exec { "Create_Northwind_Db":
		command => "$powershell $ps_sql_db_create",
		require => [File["$file_db_create"],Class['ps_sql::sqlexpress']],
		unless  => "$powershell ${ps_sql_db_exist_check}",
	}	
}