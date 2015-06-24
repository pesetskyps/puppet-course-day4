class ps_sql::fill_northwind_db(
  $instance,
  $database_check_script,
  $database_create_sql_script,
  $database_create_sql_script_windows_tmp_path,
)
{
  file { $database_create_sql_script_windows_tmp_path:
    ensure           => 'present',
    source           => $database_create_sql_script,
    source_permissions => ignore,
  }
  exec { 'create_northwind_db':
    command =>  template('ps_sql/powershell/create_northwind_database.ps1'),
    require => [File[$database_create_sql_script_windows_tmp_path],Class['ps_sql::powershell_module']],
    unless  =>  template($database_check_script),
    provider => powershell,
  }
}
