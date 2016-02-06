define common::virtual::directory_dependency($directory_array){
	#defines virtual resources. This is the dependency for directory c:\ps\site and c:\ps\service
	@file {
	$directory_array:
		ensure => directory,
	}
}