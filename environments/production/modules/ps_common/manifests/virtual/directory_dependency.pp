define ps_common::virtual::directory_dependency($directory_array,$dependency_is_for){
	#defines virtual resources. This is the dependency for directory c:\ps\site and c:\ps\service
	@file {$directory_array:
		ensure => directory,
		tag => $dependency_is_for
	}
}