# Class: ps_m4_examples::params
#
#
class ps_m4_examples::params {
  $sitename='longlongname' # minimum value
  case $::osfamily {
      'Debian': {
        $foldername='ps_deb_name_default'
      }
      
      'RedHat': {
        $foldername = 'ps_rh_value_default'
      }
    default: {fail('not supported operating system')}
  }
  notify {"folder from params = ${foldername}":}
}
