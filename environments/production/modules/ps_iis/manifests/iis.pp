class ps_iis::iis($featuresToInclude='IIS-WebServer', $featuresToExclude=''){
  #uninstall
  if($featuresToExclude != ''){
    dism {$featuresToExclude:
      ensure  => absent,    
    }
  }

  #install
  dism {$featuresToInclude:
    ensure  => present,
    all     => true,
  }
}
