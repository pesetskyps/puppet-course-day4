$powershell = 'C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -ExecutionPolicy RemoteSigned -noprofile -nologo -noninteractive -command'
node default {
    $configs = {
      'web.config' => { 
        'windows_config_path' => "c:\\ps\\service\\NorthWind.console.exe.config",
        'puppet_template_path' => "windows_service/NorthWind.console.exe.config.erb",
        'values' => { 
          'connectionstring' => "value",
          'server' => "localhost",
        }
      },
      # 'app.config' => { 'ff' => "value",'server' => "localhost",}
    }
    $v =$configs['web.config']['connectionstring']
  $configs.each |String $index, Hash $value| {
    notify { "$value": }
  }
}
node 'win-r3sga74n50h' {
  include common
  include ps_common::firewall
  class {'ps_web::iis':
    featuresToInclude => ['IIS-WebServer','IIS-StaticContent','IIS-ASPNET45'],
    featuresToExclude => ['IIS-HttpErrors']
  }

  include profile::dev::mysite
  include profile::dev::myservice        
 
  # class {'ps_app::myservice':
  #   user => 'LocalSystem',
  #   pass => '\"\"',
  # }
  # include ps_sql::sqlexpress
  # class {'ps_sql::fill_northwind_db':
  #   instance => 'dsccl1'
  # }
}
