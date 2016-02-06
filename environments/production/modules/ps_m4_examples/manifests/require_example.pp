# Class: ps_m4_examples::require_example
#
#
class ps_m4_examples::require_example {

	# without this it will fail, cause there is no class defined when require comes
	include ps_m4_examples::required_class
	
	notify{"I need a class":
		require => Class['ps_m4_examples::required_class']
	}
}
