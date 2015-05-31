$powershell = 'C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -ExecutionPolicy RemoteSigned -noprofile -nologo -noninteractive -command'
node default {

}
node 'win-r3sga74n50h' {
  include profile::dev::base
  include profile::dev::iis
  include profile::dev::mysite
  include profile::dev::myservice        
  include profile::dev::sqlexpress
  include profile::dev::create_northwind_database
}
