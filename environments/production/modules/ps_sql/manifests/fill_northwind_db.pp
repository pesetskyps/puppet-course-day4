class ps_sql::fill_northwind_db($instance){
	$import_module = "import-module \'C:\\Program Files\\Microsoft SQL Server\\120\\Tools\\PowerShell\\Modules\\sqlps\'"
	$ps_sql_db_exist_check = "\"$import_module; invoke-sqlcmd -Query \'use Northwind;select top 1 * from orders\' -ServerInstance $instance -ErrorAction Stop\""
	$file_db_create = "c:\\temp\\instnwnd.sql"
	$ps_sql_db_create = "\"$import_module; invoke-sqlcmd -InputFile \"$file_db_create\" -ServerInstance $instance -ErrorAction Stop\""

	file { "$file_db_create":
		ensure  => "present",
		source  => "puppet:///modules/ps_sql/instnwnd.sql",
		source_permissions => ignore,
	}
	exec { "Create_Northwind_Db":
		command => "$powershell $ps_sql_db_create",
		require => [File["$file_db_create"],Class['ps_sql::powershell_module']],
		unless  => "$powershell ${ps_sql_db_exist_check}",
	}	
}