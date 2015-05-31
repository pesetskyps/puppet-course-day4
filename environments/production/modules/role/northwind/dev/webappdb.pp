class role::northwind::dev::webappdb inherits role {
	include profile::dev::base
	include profile::dev::iis
	include profile::dev::mysite
	include profile::dev::myservice        
	include profile::dev::sqlexpress
	include profile::dev::create_northwind_database
}