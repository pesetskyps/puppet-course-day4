class role::northwind::dev::webappdb inherits role {
	include profile::dev::iis
	include profile::dev::mysite
	include profile::dev::myservice
	include profile::dev::sqlexpress
	include profile::dev::northwinddb
}