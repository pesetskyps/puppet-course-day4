class ps_common::prepare_new_server($role){
  #file { "c:\\ps\\" :
  #  ensure  => directory,
  #  sourcepermissions => ignore
  #}
  if($role == 'web'){
    $directories = ['c:\ps','c:\ps\site','c:\ps\logs']
  }
  if($role == 'app'){
    $directories = ['c:\ps','c:\ps\service','c:\ps\logs']
  }
  ps_common::create_directories {$role:
    directoryArray => $directories
  }
  
}
