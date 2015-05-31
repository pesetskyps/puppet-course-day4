$powershell = 'C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -ExecutionPolicy RemoteSigned -noprofile -nologo -noninteractive -command'
node default {

}
node 'win-r3sga74n50h' {
  include role::northwind::dev::webappdb
}
