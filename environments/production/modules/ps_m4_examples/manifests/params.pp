# Class: ps_m4_examples::params
#
#
class ps_m4_examples::params {
	$sitename="longlongname" # minimum value
	$notify_me =false
    $myhashparam = {config => 'web.config'}

	case $::osfamily {
	    'Debian': {
	       $foldername="ps_deb_name_default"
	    }
	    
	    'RedHat': {
	       $foldername = "ps_rh_value_default"
	    }
	}
	notify {"folder from params = $foldername":}
}
