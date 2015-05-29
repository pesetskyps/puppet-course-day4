class profile::dev::mysite{
	#icnlude is a workaround to give the parameters to iis_site::createsite defined type. Classes are evaluated first by puppet, so we will have the values for defined type provided
	#use Hiera instead
	include iis_site::params
	iis_site::createsite {'profile::dev::mysite':
		sitedirectory => "c:\\ps\\mysite",
		bindings => ['http/*:25999:'],  
	}
}