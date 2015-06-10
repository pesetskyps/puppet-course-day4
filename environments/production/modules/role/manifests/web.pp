# Class: role::web
#
#
class role::web {
	include profile::simple_iis
	include profile::simple_mysite
}