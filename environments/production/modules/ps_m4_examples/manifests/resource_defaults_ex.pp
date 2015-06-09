# Class: ps_m4_examples::resource_defaults_ex
#
#
class ps_m4_examples::resource_defaults_ex {
	File{
		mode => '755',
		owner => root,
		ensure => present,
	}

	file {"/tmp/test1":}
	file {"/tmp/test2":
		ensure => directory,
	}
}