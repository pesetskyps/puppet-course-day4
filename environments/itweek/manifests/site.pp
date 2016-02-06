$powershell = 'C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -ExecutionPolicy RemoteSigned -noprofile -nologo -noninteractive -command'
$global_var = 'globalvar'

node default {
  $node_var = "node_var"
  # system => "web-app-db",
  # $system = "web-app-db"
  class { 'zabbix_agent' :
    zabbix_server_ip => "10.240.48.45",
    system          => "web-app-db",
  }
  class { 'nxlog' :
    system => "web-app-db",
  }
  notify{"bla":}
  include role::northwind::dev::webappdb
  # #roles and profiles
  # include role::web
}

# node 'win-r3sga74n50h' {
#  include role::northwind::dev::webappdb
#   # include role::web
# # notify{"bla":}
# }
