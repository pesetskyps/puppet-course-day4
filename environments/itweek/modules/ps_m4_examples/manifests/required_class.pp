# Class: ps_m4_examples::required_class
#
#
class ps_m4_examples::required_class {
	file { '/tmp/test':
		ensure => file,
	}
}