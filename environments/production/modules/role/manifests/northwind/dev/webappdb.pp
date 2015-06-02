class role::northwind::dev::webappdb inherits role {
	create_resources('class',hiera('classes'))
}