class ps_iis::iis($featuresToInclude, $featuresToExclude='undef'){

  #install
  dism {$featuresToInclude:
    ensure  => present,
    all     => true,
  }

  #uninstall
  if($featuresToExclude != 'undef'){
    dism {$featuresToExclude:
      ensure  => absent,
      require => Dism[$featuresToInclude]   
    }
  }
}
