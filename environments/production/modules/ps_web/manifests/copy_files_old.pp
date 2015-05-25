class ps_web::copy_files_old{
	file { 'C:\ps':
	  ensure  => directory,
	  source_permissions => ignore,
	}
	file { 'C:\ps\site':
	  ensure  => directory,
	  source_permissions => ignore,
	  require => File['C:\ps']
	}
	unzip { "web.zip":
	    source  => 'C:\temp\web.zip',
	    creates => 'C:\ps\site\web.config',
	    require => File['C:\ps\site']
	}
}