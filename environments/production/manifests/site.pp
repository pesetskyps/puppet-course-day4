$powershell = 'C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -ExecutionPolicy RemoteSigned -noprofile -nologo -noninteractive -command'
node default {
    $configs = {
      'web.config' => { 'connectionstring' => "value",'server' => "localhost",},
      'app.config' => { 'ff' => "value",'server' => "localhost",}
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
           
  windows_service::create_service{"myservice":
    servicename => "myservice",
    servicedirectory => "c:\\ps\\service\\myservice",
    exe_Name => "NorthWind.console.exe",
    startup_type => "auto",
    username => "LocalSystem",
    password => "`\"`\""
  }
  windows_service::create_service{"theirservice":
    servicename => "theirservice",
    servicedirectory => "c:\\ps\\service\\theirservice",
    exe_Name => "theirservice.console.exe",
    # startup_type => "auto",
    username => "LocalSystem",
    password => "`\"`\"",
    configs => {
      'web.config' => { 'connectionstring' => "value",'server' => "localhost",},
      'app.config' => "some other value",
    }
  }  
  # class {'ps_app::myservice':
  #   user => 'LocalSystem',
  #   pass => '\"\"',
  # }
  # include ps_sql::sqlexpress
  # class {'ps_sql::fill_northwind_db':
  #   instance => 'dsccl1'
  # }
}
