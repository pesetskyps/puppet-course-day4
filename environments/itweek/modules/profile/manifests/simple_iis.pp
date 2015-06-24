# Class: profile::simple_iis
#
#
class profile::simple_iis {
  class {'ps_iis::iis':
    featuresToInclude => ['IIS-WebServer']
  }
}