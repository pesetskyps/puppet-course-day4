class ps_iis::iis($featuresToInclude, $featuresToExclude){

  #install
  dism {$featuresToInclude:
    ensure  => present,
    all     => true,
  }

  #uninstall
  if($featuresToExclude != ''){
    dism {$featuresToExclude:
      ensure  => absent,
      require => Dism[$featuresToInclude]   
    }
  }
}
