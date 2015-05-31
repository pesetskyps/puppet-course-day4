class ps_sql::fill_northwind_db(
  $instance,
  $database_check_script,
  $database_create_sql_script,
)
{
  $file_db_create = "c:\\temp\\instnwnd.sql"

  file { $file_db_create:
    ensure           => 'present',
    source           => $database_create_sql_script,
    source_permissions => ignore,
  }
  exec { 'create_northwind_db':
    command =>  template('ps_sql/powershell/create_northwind_database.ps1'),
    require => [File[$file_db_create],Class['ps_sql::powershell_module']],
    unless  =>  template($database_check_script),
    provider => powershell,
  }
}
