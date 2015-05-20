class ps_web::iis() {

  #Install IIS-Role and features from answer file
  dism {'IIS-WebServer':
    ensure  => present,
    all 	=> true
  }
  dism {'IIS-StaticContent':
    ensure  => present,
    require => Dism['IIS-WebServer']
  }  
}
