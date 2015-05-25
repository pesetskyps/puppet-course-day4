$powershell = 'C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -ExecutionPolicy RemoteSigned -noprofile -nologo -noninteractive -command'

node 'dsccl1.hosting.ad.viacom.com' {
  include common
  # include ps_common::firewall
  # include ps_web::iis
  # class {'ps_web::mysite':
  #   user => 'hosting\pesetskp',
  #   pass => 'Epam_2010',
  # }
  # class {'ps_app::myservice':
  #   user => 'hosting\pesetskp',
  #   pass => 'Epam_2010',
  # }
  # include ps_sql::sqlexpress
  # class {'ps_sql::fill_northwind_db':
  #   instance => 'dsccl1'
  # }
  # Vedmich
}
