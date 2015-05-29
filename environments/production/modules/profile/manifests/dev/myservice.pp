class profile::dev::myservice{
  windows_service::create_service{"myservice":
    servicename => "myservice",
    servicedirectory => "c:\\ps\\service\\myservice",
    exe_Name => "myservice.console.exe",
    startup_type => "auto",
    username => "LocalSystem",
    password => "`\"`\"",
    configs => {
      'web.config' => { 
        'windows_config_path' => "c:\\ps\\service\\myservice\\NorthWind.console.exe.config",
        'puppet_template_path' => "windows_service/NorthWind.console.exe.config.erb",
        'values' => { 
          'connectionstring' => "data source=localhost,1433;initial catalog=Northwind;User Id=sa; password=Epam_2010;",
          'wcfserver' => "localhost",
        }
      },
      # 'app.config' => { 'ff' => "value",'server' => "localhost",}
    }
  }
} 