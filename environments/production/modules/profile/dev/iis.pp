class profile::dev::iis {
  class {'ps_web::iis':
    featuresToInclude => ['IIS-WebServer','IIS-StaticContent','IIS-ASPNET45'],
    featuresToExclude => ['IIS-HttpErrors']
  }
}