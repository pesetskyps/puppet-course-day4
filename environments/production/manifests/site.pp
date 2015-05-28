$powershell = 'C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -ExecutionPolicy RemoteSigned -noprofile -nologo -noninteractive -command'

node 'win-r3sga74n50h' {
  include common
  include ps_common::firewall
  class {'ps_web::iis':
    featuresToInclude => ['IIS-WebServer','IIS-StaticContent','IIS-ASPNET45'],
    featuresToExclude => ['IIS-HttpErrors']
  }
  class {'ps_web::mysite':
    bindings => ['http/*:25999:'],
    sitedirectory => "c:\\ps\\mysite"
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
