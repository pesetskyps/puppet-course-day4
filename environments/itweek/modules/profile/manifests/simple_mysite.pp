# Class: profile::simple_mysite
#
#
class profile::simple_mysite {
  iis_site::createsite{'mysite':
    sitedirectory => 'c:\ps\site\mysite',
    bindings => ['http/*:25999:'],
    sitename => 'mysite',
    id => 13,
    #apppool settings
    user => 'NetworkService',
    pass => '',
    enable32app => false,
    apppoolname => 'mysite',
    managedruntimeversion => 'v4.0',
    queuelength => 10000,
    #logging settings
    logdirectory => 'c:\inetpub\logs',
    logfile_fields => 'Date, Time, ClientIP, UserName, ServerIP, Method, UriStem, UriQuery, HttpStatus, TimeTaken, ServerPort, UserAgent, Referer, Host',
    log_rotation_period => 'Hourly',
    logfile_enabled => 'true',
  }
}