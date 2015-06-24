class iis_site::params(
  #site settings
  $sitedirectory='',
  $bindings='',
  $sitename = 'mysite',
  $id = '',
  #deplyment settings
  Variant[Boolean, Enum['true', 'false']]
  $deploy =false, 
  $deploypackLocation='',

  #apppool settings
  $user='NetworkService',
  $pass='',
  $enable32app=false,
  $apppoolname = 'mysite',
  $managedruntimeversion = 'v4.0',
  $queuelength = '10000',

  #logging settings
  $logdirectory = "$sitedirectory\\logs",
  $logfile_fields = 'Date, Time, ClientIP, UserName, ServerIP, Method, UriStem, UriQuery, HttpStatus, TimeTaken, ServerPort, UserAgent, Referer, Host',
  Variant[String, Enum['Daily', 'Hourly','MaxSize','Monthly','Weekly']]
  $log_rotation_period = 'Hourly',
  Variant[Boolean, Enum['true', 'false']]
  $logfile_enabled = true,
){
	if $::osfamily != 'windows' {
		fail("This module can only be applied to windows")	
	}
	
	if(($deploy == true) and ($deploypackLocation = '')){
		fail("Please specify the deploy pack location at puppet master in format: puppet:///<modulename>/<path in module files directory>")
	}
}