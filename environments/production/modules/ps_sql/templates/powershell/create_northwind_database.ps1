import-module "C:\Program Files\Microsoft SQL Server\120\Tools\PowerShell\Modules\sqlps"
invoke-sqlcmd -InputFile "<%= @database_create_sql_script_windows_tmp_path%>" -ServerInstance <%= @instance %> -ErrorAction Stop -username "sa" -password "Zabbix_2015"
